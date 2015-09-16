<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\LoginAttempts;
use App\Models\Customer;
use App\Models\UserActivationToken;
use App\Models\RoleUser;
use App\Models\Role;
use App\Models\UsersIp;
use Input;
use Response;
use Mail;
use Hash;
use DB;
use Crypt;

class UserController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        //
        //to optain all countrys
        $users = \App\Models\User::all();
        return $users;
    }

    public function countUsers() {
        $users = DB::table('users')->count();
        return $users;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create() {

        //customer that create
        $id_invite = Input::get('customer_current');
        $customer_invite = Customer::find($id_invite);

        $new = new \App\Models\User();
        $new->name = Input::get('name');
        $new->username = Input::get('username');
        $user_create = Input::get('username');
        $new->email = Input::get('email');
        $new->lastname = Input::get('lastname');
        $new->customers_id = $customer_invite->id;
        $new->password = Hash::make($new->email);
        $new->role_id = Input::get('myRolSelect');
        $new->active = 0;
        $email_user = Input::get('email');
        $count = 0;
        $exist_username = User::where('username', $new->username)->count();
        $exist_user_customer = DB::table('users')
                ->whereCustomers_idAndEmail($id_invite, $new->email)
                ->first();
        $exist_email = User::where('email', $new->email)->count();
        if ($exist_username > 0 && $exist_email > 0) {
            $count = $count + 1;
            return response()->json(['error' => true, 'username_err' => 1, 'email_err' => 1], 400);
        } elseif ($exist_email > 0 && $exist_user_customer != '') {
            return response()->json(['error' => true, 'email_err' => 1, 'user_customer' => 1], 400);
        } elseif ($exist_username > 0) {
            $count = $count + 1;
            return response()->json(['error' => true, 'username_err' => 1], 400);
        } else if ($count == 0) {
            $new->save();
            $total_user = User::all()->last();
            $user_id = $total_user->id;
            $new = new RoleUser();
            $new->role_id = Input::get('myRolSelect');
            $new->user_id = $user_id;
            $new->save();


            //customer that create
            $id_invite = Input::get('customer_current');
            $customer_invite = Customer::find($id_invite);

            //  Create Activation token to activate the account
            $activation_token = new UserActivationToken;
            $activation_token->user_id = $user_id;
            $activation_token->token = md5(uniqid(date('mdYhis'), true));

            $activation_token->save();

            $activation_url = url('/PayAnyBiz/Activation', ['token' => $activation_token->token]);

            $data = array('email' => $email_user, 'name' => $customer_invite->legal_name, 'username' => $user_create);

            Mail::send('emails.crearUser', array('name' => $data['name'], 'email' => $data['email'], 'username' => $data['username'], 'url' => $activation_url), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
            });

            return Response::json([
                        'success' => true
                            ], 200);
        }
	}
	
	
    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store(Request $request) {
        
    }

    public function rolByUser($id) {
        $rol_user = RoleUser::where('user_id', $id)->get();
        $rol = Role::where('id', $rol_user[0]->role_id)->get();
        return $rol[0]->name;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id) {
        return \App\Models\User::find($id);
    }
	public function newCSuser() {
		//customer that create
		$password = $this->randomPassword();
        $id_invite = Input::get('customer_current');
        $customer_invite = Customer::find($id_invite);
        $new = new \App\Models\User();
        $new->name = Input::get('name');
        $new->username = Input::get('username');
        $user_create = Input::get('username');
        $new->email = Input::get('email');
        $new->lastname = Input::get('lastname');
        $new->customers_id = $customer_invite->id;
        $new->password = Hash::make($password);
        $new->role_id = Input::get('role_id');
        $new->active = 0;
        $email_user = Input::get('email');
        $count = 0;
        $exist_username = User::where('username', $new->username)->count();
        $exist_user_customer = DB::table('users')
                ->whereCustomers_idAndEmail($id_invite, $new->email)
                ->first();
        $exist_email = User::where('email', $new->email)->count();
        if ($exist_username > 0 && $exist_email > 0) {
            $count = $count + 1;
            return response()->json(['error' => true, 'username_err' => 1, 'email_err' => 1], 400);
        } elseif ($exist_email > 0 && $exist_user_customer != '') {
            return response()->json(['error' => true, 'email_err' => 1, 'user_customer' => 1], 400);
        } elseif ($exist_username > 0) {
            $count = $count + 1;
            return response()->json(['error' => true, 'username_err' => 1], 400);
        } else if ($count == 0) {
            $new->save();
            $total_user = User::all()->last();
            $user_id = $total_user->id;
            $new = new RoleUser();
            $new->role_id = Input::get('role_id');
            $new->user_id = $user_id;
            $new->save();


            //customer that create
            $id_invite = Input::get('customer_current');
            $customer_invite = Customer::find($id_invite);

            //  Create Activation token to activate the account
            $activation_token = new UserActivationToken;
            $activation_token->user_id = $user_id;
            $activation_token->token = md5(uniqid(date('mdYhis'), true));
			
            $activation_token->save();

            $activation_url = url('/PayAnyBiz/Activation', ['token' => $activation_token->token]);

            $data = array('email' => $email_user, 'name' => $customer_invite->legal_name, 'username' => $user_create);

            Mail::send('emails.newUserWithTempPwd', array('name' => $data['name'], 'email' => $data['email'], 'username' => $data['username'], 'password' => $password), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
            });

            return Response::json([
                        'success' => true
                            ], 200);
        }
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
    public function getDetails($customer_id) {
        $users = DB::table('users')->where('users.customers_id', '=', $customer_id)->limit(1)->get();
        return $users;
    }

    public function listMyUsersRol($id) {
        $all_users = User::all();
        $user = User::where('id', $id)->find($id);
        if ($user->role_id == 5) {
            $my_users = User::where('customers_id', $user->customers_id)->where('active', 1)->get();
            return $my_users;
        } else {
            return $user;
        }
    }

    public function listUsersByCompany($id) {
        $my_users = User::where('customers_id', $id)->whereNotIn('role_id', [8])->get();
        return $my_users;
    }
	public function listUsersByRole($id) {
        $my_users = User::where('role_id', $id)->get();
        return $my_users;
    }
    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function edit($id) {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function update($id) {


        $user = \App\Models\User::find($id);
        $user->name = Input::get('name');
        $user->username = Input::get('username');
        $user->email = Input::get('email');
        $user->lastname = Input::get('lastname');
        $user->role_id = Input::get('role_id');
        $user->active = 1;
        $count = 0;
        $user->count();
        $exist_username = User::where('username', $user->username)->count();
        $exist_user = User::where('username', $user->username)->get();
//        $exist_email = User::where('email', $user->email)->count();
//        $exist_email_id = User::where('email', $user->email)->get();
        $exist_user_customer = DB::table('users')
                ->whereCustomers_idAndEmail($user->customers_id, $user->email)
                ->first();

        if (($exist_username >= 1 && $exist_user[0]->id != $id) && (($exist_user_customer != '') && $exist_user_customer->id != $id)) {
            $count = $count + 1;
            return response()->json(['error' => true, 'username_err' => 1, 'email_err' => 1], 400);
        } elseif (($exist_user_customer != '') && ($exist_user_customer->id != $id )) {
            $count = $count + 1;
            return response()->json(['error' => true, 'email_err' => 1], 400);
        } elseif ($exist_username >= 1 && $exist_user[0]->id != $id) {
            $count = $count + 1;
            return response()->json(['error' => true, 'username_err' => 1], 400);
        } else if ($count == 0) {
            $user->save();
            $customer_invite = "PayaniBiz";

            $data = array('email' => $user->email, 'name' => $customer_invite);

            Mail::send('emails.updatedUser', array('name' => $data['name'], 'email' => $data['email']), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('Updated to PayAnyBiz!');
            });
            return Response::json([
                        'success' => true
                            ], 200);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function destroy($id) {
        //
        $users = \App\Models\User::destroy($id);

        return Response::json($users);
    }

    public function changePasswordAfterSixtyDays($id) {
        $user = User::find($id);
       
		if ($user->attempts_daily < 5) {
            $user->attempts_daily = 0;
        }
        $user->save();
        $password_updated = $user->date_password_changed;
        $today = date_default_timezone_get();

//        $interval = $password_updated->diff($today);
        $interval = strtotime($today) - strtotime($password_updated);
        if (($interval - 5184000) > 0) {
            //Create Activation token to activate the account
            $activation_token = new UserActivationToken;
            $activation_token->user_id = $user->id;
            $activation_token->token = md5(uniqid(date('mdYhis'), true));

            $activation_token->save();

            $activation_url = url('/PayAnyBiz/Activation', ['token' => $activation_token->token]);

            $data = array('email' => $user->email, 'name' => $user->name);
			
           // Mail::send('emails.changePass', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
                //$message->to($data['email'], $data['name'])->subject('You should change your password to PayAnyBiz!');
            //});

            return Response::json([
                        'success' => true
                            ], 200);
            //   5443200
        } else if (($interval - 5443200) > 0 || ($user->attempts_daily > 5)) {
            return Response::json([
                        'error' => true
                            ], 201);
        }
    }
	public function lock_status($id) {
		$user = User::find($id);
		$user->is_locked = Input::get('lockStatus');
		$user->save();
		if(Input::get('lockStatus') == 0){
			$lgn_cnt = LoginAttempts::where('user_id',$id)->count();
			if($lgn_cnt > 0){
				LoginAttempts::where('user_id', $id)->delete();
			}
		}
	}
	public function user_status($id) {
		$user = User::find($id);
		$user->active = Input::get('status');
		$user->save();
	}
	
    public function lockUserAfterFourAttempts($id) {
        $user = User::where('username', $id)->first();

        if (empty($user)) {
            return null;
        }
        $user->attempts_daily = $user->attempts_daily + 1;
        $user->save();
        $count = $user->attempts_daily;
        if ($user->attempts_daily >= 5) {
            return Response::json([
                        'error' => true,
                        'count' => $count
                            ], 201);
        } else {
            return null;
        }
    }

    function verifyIp() {
        $verification_code = Input::get('verificationCode');
        $userIpDetails = UsersIp::where('token', $verification_code)->first();
        if (!empty($userIpDetails)) {
            $userIp = UsersIp::find($userIpDetails->id);
            $userIp->status = 1;
            $userIp->token = '';
            $userIp->save();
            return Response::json(['success' => true, 'user' => User::where('id', $userIpDetails->id)->first()], 200);
        } else {
            return Response::json(['error' => true, 'msg' => 'Invalid code.'], 200);
        }
    }

    function checkIp() {
        $user_id = Input::get('id');
        if (empty($user_id)) {
            return Response::json(['success' => false], 200);
        }
        $ipDetails = UsersIp::where('user_id', $user_id)->where('ip_address', $_SERVER['REMOTE_ADDR'])->orderBy('id', 'DESC')->first();
        if (!empty($ipDetails)) {
            if (!empty($ipDetails->token)) {
                $data = array('email' => Input::get('email'), 'name' => Input::get('name'));
                Mail::send('emails.verifyIp', array('name' => $data['name'], 'email' => $data['email'], 'token' => $ipDetails->token), function($message) use ($data) {
                    $message->to($data['email'], $data['name'])->subject('Ip Address vefification!');
                });
                return Response::json(['error' => true], 200);
            }
            return Response::json(['success' => true], 200);
        } else {
            $digits = 5;
            $token = rand(pow(10, $digits - 1), pow(10, $digits) - 1);
            $userIp = new UsersIp;
            $userIp->user_id = $user_id;
            $userIp->ip_address = $_SERVER['REMOTE_ADDR'];
            $userIp->status = 1;
            $userIp->token = $token;
            $userIp->updated_at = date('Y-m-d H:i:s');
            $userIp->created_at = date('Y-m-d H:i:s');
            $userIp->save();

            $data = array('email' => Input::get('email'), 'name' => Input::get('name'));

            Mail::send('emails.verifyIp', array('name' => $data['name'], 'email' => $data['email'], 'token' => $token), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('Ip Address vefification!');
            });
            return Response::json(['error' => true], 200);
        }
    }

    public function multiexplode( $string) {
        $delimiters = array("\"","|","\\","/");
        $ready = str_replace($delimiters, $delimiters[0], $string);
        $launch = explode($delimiters[0], $ready);
        return $launch;
    }

    public function updateProfile($id, Request $request) {
        $user = User::where('id', $id)->first();
        $user->name = $request->name;
        $user->username = $request->username;
        $user->email = $request->email;
        $user->lastname = $request->lastname;
        $user->phone = $request->phone;
        if($request->image_profile != null){
         $urls =   UserController::multiexplode($request->image_profile);
//             $user->image_profile = basename($request->image_profile);
           $user->image_profile=  array_pop($urls);
        }      
        $old_pass = $request->old_password;
        $new_pass = $request->password;
        $conf_pass = $request->confirm_password;
        $old_pass_decrypt = Crypt::decrypt($user->passw_decrypt);
        while ($request->password != null) {
            if (strlen(Input::get('password')) < 8 || strlen(Input::get('password')) > 15) {
                return response()->json(['error' => true, 'password_err' => 1], 400);
            }
            if ((Input::get('password')) != ($conf_pass)) {
                return response()->json(['error' => true, 'password_err' => 6], 400);
            }
            if ($old_pass != $old_pass_decrypt) {
                return response()->json(['error' => true, 'password_err' => 0], 400);
            }
            if (!preg_match('/(?=[a-z])/', $new_pass)) {
                return response()->json(['error' => true, 'password_err' => 2], 400);
            }
            if (!preg_match('/(?=[A-Z])/', $new_pass)) {
                return response()->json(['error' => true, 'password_err' => 3], 400);
            }
            if (!preg_match('/(?=\d)/', $new_pass)) {
                return response()->json(['error' => true, 'password_err' => 4], 400);
            }
            if (!preg_match('/(?=[!@#$%&]|-|_)/', $new_pass)) {
                return response()->json(['error' => true, 'password_err' => 5], 400);
            }
            if ($new_pass == $old_pass_decrypt) {
                return response()->json(['error' => true, 'password_err' => 7], 400);
            }
            if ($request->password != $old_pass_decrypt) {

                $user->password = Hash::make(Input::get('password'));
                $user->passw_decrypt = Crypt::encrypt(Input::get('password'));
                $user->date_password_changed = date('Y-m-d');
                $user->attempts_daily = 0;
                $user->active = 1;
                $user->save();

                $data = array('email' => $user->email, 'name' => $user->name);

                Mail::send('emails.updatedUser', array('name' => $data['name'], 'email' => $data['email']), function($message) use ($data) {
                    $message->to($data['email'], $data['name'])->subject('Updated to PayAnyBiz!');
                });
                return Response::json([
                            'name' => $user->name,
                            'oldpass' => $old_pass,
                            'success' => true
                                ], 200);
            }
        }
        $user->active = 1;
        $user->save();

        $data = array('email' => $user->email, 'name' => $user->name);

        Mail::send('emails.updatedUser', array('name' => $data['name'], 'email' => $data['email']), function($message) use ($data) {
            $message->to($data['email'], $data['name'])->subject('Updated to PayAnyBiz!');
        });
        return Response::json([
                    'name' => $user->name,
                    'oldpass' => $old_pass,
                    'success' => true
                        ], 200);
    }
    
    
        public function searchDataUser($id) {
        //DB::enableQueryLog(); //Un comment this line to print SQL Query		 

        $query = DB::table('users')
                ->join('customers', 'users.customers_id', '=', 'customers.id')
                ->where('users.id', '=', $id);

        $query->select('users.*', 'customers.legal_name');

        $searchResults = $query->get();
        //print_r(DB::getQueryLog());
        return $searchResults;
    }

}
