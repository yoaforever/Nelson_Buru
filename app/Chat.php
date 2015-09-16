<?php namespace App;

/*use Illuminate\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;

use App\Models\Customer;
use App\Models\SystemFunction;*/

use DB;
use Session;
use Auth;

class Chat{
	
	public static function login($name,$email){
		if(!$name || !$email){
			throw new Exception('Fill in all the required fields.');
		}
		
		if(!filter_input(INPUT_POST,'email',FILTER_VALIDATE_EMAIL)){
			throw new Exception('Your email is invalid.');
		}
		
		// Preparing the gravatar hash:
		$gravatar = md5(strtolower(trim($email)));
		
		$user = new ChatUser(array(
			'name'		=> $name,
			'gravatar'	=> $gravatar
		));
		
		// The save method returns a MySQLi object
		if($user->save()->affected_rows != 1){
			throw new Exception('This nick is in use.');
		}
		
		$_SESSION['user']	= array(
			'name'		=> $name,
			'gravatar'	=> $gravatar
		);
		
		return array(
			'status'	=> 1,
			'name'		=> $name,
			'gravatar'	=> Chat::gravatarFromHash($gravatar)
		);
	}
	
	public static function checkLogged(){
		$response = array('logged' => false);
			
		if($_SESSION['user']['name']){
			$response['logged'] = true;
			$response['loggedAs'] = array(
				'name'		=> $_SESSION['user']['name'],
				'gravatar'	=> Chat::gravatarFromHash($_SESSION['user']['gravatar'])
			);
		}
		
		return $response;
	}
	
	public static function logout(){
		DB::query("DELETE FROM webchat_users WHERE name = '".DB::esc($_SESSION['user']['name'])."'");
		
		$_SESSION = array();
		unset($_SESSION);

		return array('status' => 1);
	}
	
	public static function submitChat($senderid,$receiverid,$chatText){
		/*if(!$_SESSION['user']){
			throw new Exception('You are not logged in');
		}
		*/
		if(!$chatText){
			throw new Exception('You haven\' entered a chat message.');
		}
		
		$insertID = DB::table('webchat_messages')->insertGetId(
		  ['sender_id' => $senderid, 'receiver_id' => $receiverid, 'message'=>$chatText]
		);
		// The save method returns a MySQLi object
		return array(
			"status"	=> 1,
			"insertID"	=> $insertID
		);
	}
	
	public static function getUsers(){
		if($_SESSION['user']['name']){
			$user = new ChatUser(array('name' => $_SESSION['user']['name']));
			$user->update();
		}
		
		// Deleting chats older than 5 minutes and users inactive for 30 seconds
		
		DB::query("DELETE FROM webchat_lines WHERE ts < SUBTIME(NOW(),'0:5:0')");
		DB::query("DELETE FROM webchat_users WHERE last_activity < SUBTIME(NOW(),'0:0:30')");
		
		$result = DB::query('SELECT * FROM webchat_users ORDER BY name ASC LIMIT 18');
		
		$users = array();
		while($user = $result->fetch_object()){
			$user->gravatar = Chat::gravatarFromHash($user->gravatar,30);
			$users[] = $user;
		}
	
		return array(
			'users' => $users,
			'total' => DB::query('SELECT COUNT(*) as cnt FROM webchat_users')->fetch_object()->cnt
		);
	}
	
	public static function getChats($senderid,$receiverid){
	   
		/*$result = DB::query('SELECT * FROM webchat_lines WHERE id > '.$lastID.' ORDER BY id ASC
	  (CASE WHEN users.name=\'Rajendra\' THEN \'Me\' ELSE users.name END)
	  ');*/
	  
	  $chatresult = DB::table('webchat_messages')
	              ->select('webchat_messages.*', DB::raw('(CASE WHEN users.name="'.Auth::user()->name.'" THEN "Me" ELSE users.name END) as author'))
	              ->join('users', function($join){
	                $join->on('users.id', '=', 'webchat_messages.sender_id');
	              })
	              
	              ->whereIn('sender_id', [$senderid, $receiverid])
            	  ->whereIn('receiver_id', [$senderid, $receiverid])
            	  ->orderBy('ts', 'desc')
            	  ->get();
	  $chats = array();
		  foreach($chatresult as $chat){
			// Returning the GMT (UTC) time of the chat creation:
			$chat->time = array(
				'hours'		=> date('H',strtotime($chat->ts)),
				'minutes'	=> date('i',strtotime($chat->ts)),
			    'ampm'	=> date('a',strtotime($chat->ts))
			);
			
			//$chat->gravatar = Chat::gravatarFromHash($chat->gravatar);
			
			$chats[] = $chat;
		}
	
		return array('chats' => $chats);
	}
	public static function getChatsOfUser($receiverid){
	   
		/*$result = DB::query('SELECT * FROM webchat_lines WHERE id > '.$lastID.' ORDER BY id ASC
	  (CASE WHEN users.name=\'Rajendra\' THEN \'Me\' ELSE users.name END)
	  ');*/
	  
	  $chatresult = DB::table('webchat_messages')
				  ->leftjoin('users', 'users.id', '=', 'webchat_messages.sender_id')
	              ->select('webchat_messages.*','users.name as sender_name')
				  
            	  ->whereIn('receiver_id', [$receiverid])
				  ->where('status','=',0)
				  ->take(2)
            	  ->orderBy('ts', 'desc')
            	  ->get();
	  $chats = array();
		  foreach($chatresult as $chat){
			// Returning the GMT (UTC) time of the chat creation:
			$chat->time = array(
				'hours'		=> date('H',strtotime($chat->ts)),
				'minutes'	=> date('i',strtotime($chat->ts)),
			    'ampm'	=> date('a',strtotime($chat->ts))
			);
			
			//$chat->gravatar = Chat::gravatarFromHash($chat->gravatar);
			
			$chats[] = $chat;
		}
	
		return array('chats' => $chats);
	}
	public static function gravatarFromHash($hash, $size=23){
		return 'http://www.gravatar.com/avatar/'.$hash.'?size='.$size.'&amp;default='.
				urlencode('http://www.gravatar.com/avatar/ad516503a11cd5ca435acc9bb6523536?size='.$size);
	}
}
