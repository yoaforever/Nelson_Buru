<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\User;
use App\Models\Customer;
use App\Models\UserActivationToken;
use App\Models\RoleUser;
use App\Models\Role;
use Hash;
use Mail;
use Input;
use Response;
use DB;
use Crypt;

class BranchesController extends Controller {
	
	/**
     * Creating new branches
     *
     * @return Response
     */	
	public function new_branch() {
		$branch = new Branch;
		$branch->users_id = 2;
		$branch->branch_name = "Lakdikapul";
		$branch->first_name = "user2";
		$branch->last_name = "user2";
		$branch->save();
		return Response::json(['success' => true], 200);
	}
	
	/**
     * Inviting branch
     *
     * @return Response
     */
	function create() {
		$password = $this->randomPassword();
        $id_invite = Input::get('customer_id');
        $customer_invite = Customer::find($id_invite);
		
		$user_create = $this->randomPassword();
		$fullname = Input::get('firstname')." ".Input::get('lastname');
        $new = new \App\Models\User();
        $new->name = Input::get('firstname');
        $new->username = $user_create;
        $new->email = Input::get('email');
        $new->lastname = Input::get('lastname');
        $new->customers_id = 0;
        $new->password = Hash::make($password);
        $new->role_id = 51;
        $new->active = 0;
        $email_user = Input::get('email');
        $count = 0;
        $exist_username = User::where('username', $new->username)->count();
        $exist_email = User::where('email', $new->email)->count();
        
		if($exist_email > 0){
			$count = $count + 1;
            return response()->json(['error' => true, 'email_err' => 1], 400);
		}
		else if ($count == 0) {
            $new->save();
            $user_id = $new->id;
			
            $role = new RoleUser();
            $role->role_id = 51;
            $role->user_id = $user_id;
            $role->save();
			
			//Creating in branch
			$branch_name = Input::get('branch_name');
			$branch = new Branch;
			$branch->customers_id = $customer_invite->id;
			$branch->branch_name = Input::get('branch_name');
			$branch_exists = $branch->where('branch_name',$branch_name)->count();
			if($branch_exists > 0){
				$branch->branch_name = "new".$branch_name;
			}
			$branch->status = 0;
			$branch->save();

            //  Create Activation token to activate the account
            $activation_token = new UserActivationToken;
            $activation_token->user_id = $user_id;
            $activation_token->token = md5(uniqid(date('mdYhis'), true));
            $activation_token->save();
			
			$enc_userid = base64_encode("user".$user_id);
			$enc_custid = base64_encode("user".$customer_invite->id);
			
            $activation_url = url('/api/branchconnect', ['user_id' => $enc_userid, 'cust_id' => $enc_custid]);
            $data = array('email' => $email_user, 'username' => $user_create, 'fullname' => $fullname, 'act_url' => $activation_url);
            Mail::send('emails.newUserWithBranch', array('email' => $data['email'], 'username' => $data['username'], 'password' => $password, 'fullname' => $data['fullname'], 'acturl' => $data['act_url']), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
            });
			
            return Response::json(['success' => true], 200);
        }
	}
	
	public function activation($userid, $custid){
		$dec_userid = substr(base64_decode($userid),4);
		$dec_custid = substr(base64_decode($custid),4);
		User::where('id', $dec_userid)->update(['customers_id' => $dec_custid, 'active' => 1 ]);
		return redirect('/');
	}
	
	public function randomPassword() {
	    $alphabet = "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ0123456789";
	    $pass = array(); //remember to declare $pass as an array
	    $alphaLength = strlen($alphabet) - 1; //put the length -1 in cache
	    for ($i = 0; $i < 8; $i++) {
	        $n = rand(0, $alphaLength);
	        $pass[] = $alphabet[$n];
	    }
	    return implode($pass); //turn the array into a string
	}
}
