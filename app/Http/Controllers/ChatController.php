<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Input;
use App\Models\Customer;
use Response;
//use Input;
//use Validator; 
//use App\User;
//use Hash;
//use Mail;
//use App\Models\UserActivationToken;
use App\Models\BankAccount;
use App\Models\User;
use DB;
use Auth;

/*Chat classes*/

use App\Chat;
use App\ChatBase;
use App\ChatLine;
use App\ChatUser;

class ChatController extends Controller {

    /**
     * Update the specified resource in storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function companyUsers($id,$data="") {
        $company_profile = Customer::find($id);
        $loggedinuser = Auth::user()->name;
		$loggedId = Auth::user()->id;
        $compnayname = $company_profile->legal_name;
        if($compnayname != '') {
          $result = DB::table('customers')
          ->select('customers.*','users.id as userid','users.name as cname','users.is_logged_in','webchat_users_status.status as chat_status')
          ->join('users', function($join){
            $join->on('users.customers_id', '=', 'customers.id');
          })
		  ->join('webchat_users_status', function($join){
            $join->on('webchat_users_status.user_id', '=', 'users.id');
          })
          ->where('customers.legal_name' ,'=', $compnayname)
          //->where('users.is_logged_in' ,'=', 1)
          //->where('users.id' ,'!=', $loggedId)
          ->get();
          
       // $query = DB::getQueryLog();
       // $lastQuery = end($query);
       // print_r($lastQuery);
		//exit;

        }
        
         return Response::json([
                    'companyusers' => $result
                        ], 200);
    }
    
    public function chatAction($action) {
      $response = array();
      // Handling the supported actions:
      //echo "<pre>";print_r($data);exit;
      $senderid = Input::get('senderid');
      $receiverid = Input::get('receiverid');
      
      switch($action){
          case 'submitchat':
          //$response = Chat::submitChat($data.message);
          $response = Chat::submitChat($senderid,$receiverid,Input::get('message'));
          break;
      
        case 'getUsers':
          $response = Chat::getUsers();
          break;
      
        case 'getchats':
          $response = Chat::getChats($senderid,$receiverid);
          break;
		case 'getReceivedMsgs':
          $response = Chat::getChatsOfUser($receiverid);
          break;
      
        default:
          throw new Exception('Wrong action');
      }
      
      return Response::json($response, 200);
    }
	
	public function update_msg_status($id) {
		DB::table('webchat_messages')
		->where('id', $id)
		->update(array('status' => 1));
		return Response::json([
                    'success' => true
                        ], 200);
	}
    /*
     * Following function returns all the companies along with no of users in that company
    * It also exludes the company of the current logged-in user
    * @author: Rajendra 18/06/2015
    * */
    public function chatCompanies($customer_id)
    {      
      $companies = array();
      $company_profile = Customer::find($customer_id);
      $compnayname = $company_profile->legal_name;
      
      $result = '';
      /*if($term != '') {
       $result =  DB::table('customers')->where('legal_name' ,'LIKE', '%' . $term . '%')->get();
      }*/
      
        $first = DB::table('customersrelations')->select('customers_id')->where('customers1_id', '=', $customer_id);
        $second = DB::table('customersrelations')->select('customers1_id')->where('customers_id', '=', $customer_id);
      
        $query = $first->unionAll($second);
        $querySql = $query->toSql();
        $companies = DB::table(DB::raw("($querySql) a "))->select(DB::raw('customers.legal_name as companyname, count(customers_id) as noofusers,customers_id'))
                      ->mergeBindings($query)
                      ->join('customers', function($join){
                        $join->on('customers_id', '=', 'customers.id');
                      })
                      ->where('customers.legal_name' ,'!=', $compnayname)
                      ->groupBy('customers.legal_name')
                      ->get();
      
     
     /*$companies = DB::table('customers')
                ->select(DB::raw('customers.legal_name as companyname, count(users.id) as noofusers'))
                ->join('users', function($join){
                  $join->on('users.customers_id', '=', 'customers.id');
                })
                ->where('customers.legal_name' ,'!=', $compnayname)
                ->groupBy('customers.legal_name')
                ->get();*/
      
     
                
      return Response::json($companies, 200);
    }
    /*
     * Following function returns all the users of a specific company
    * @author: Rajendra 18/06/2015
    * */
    public function chatCompanyUsers()
    { 
      DB::enableQueryLog();
      $customer_id = Input::get('customer_id');
      $companyname = Input::get('company');
      
        if($companyname != '') {
          
          $first = DB::table('customersrelations')->select('customersrelations.customers_id')->where('customersrelations.customers1_id', '=', $customer_id);
          $second = DB::table('customersrelations')->select('customersrelations.customers1_id')->where('customersrelations.customers_id', '=', $customer_id);
          
          $query = $first->unionAll($second); 
          $querySql = $query->toSql();
          $result = DB::table(DB::raw("($querySql) a "))
                        ->select(DB::raw('customers.*,users.id as userid,users.name as cname,users.is_logged_in, webchat_users_status.status as chat_status'))
                        ->mergeBindings($query)
                        ->join('customers', function($join){
                          $join->on('a.customers_id', '=', 'customers.id');
                        })
                        ->leftjoin('users', function($join){
                          $join->on('users.customers_id', '=', 'a.customers_id');
                        })
						 ->leftjoin('webchat_users_status', function($join){
				            $join->on('webchat_users_status.user_id', '=', 'users.id');
				          })
                        ->where('customers.legal_name' ,'=', $companyname)
                        ->get();
                        
                        /*$query = DB::getQueryLog();
                        $lastQuery = end($query);
                        print_r($lastQuery);*/
          
         /* $result = DB::table('customers')
            ->select('customers.*','users.id as userid','users.name as cname','users.is_logged_in')
            ->join('users', function($join){
              $join->on('users.customers_id', '=', 'customers.id');
            })
            ->where('customers.legal_name' ,'=', $companyname)
            ->get();*/
        }
        
        return Response::json([
                    'companyusers' => $result
                        ], 200);
    }
	
	public function set_chat_status(){
		$userid = Input::get('userid');
		$compid = Input::get('compid');
		$status = Input::get('status');
		
		$check_user = DB::table('webchat_users_status')->where('user_id', $userid)->first();
		if($check_user){
			DB::table('webchat_users_status')
			->where('id', $check_user->id)
			->update(['status' => $status]);
		}
		else{
			DB::table('webchat_users_status')->insert(['user_id' => $userid, 'company_id' => $compid, 'status' => $status, created_at => date('Y-m-d h:i:s')]);
		}
	}
	
	public function get_chat_status($id){
	
		$check_user = DB::table('webchat_users_status')->where('user_id', $id)->first();
		return $check_user->status;
	}
	public function recent_messages() {
		$customer_id = Input::get('customer_id');
	}
}