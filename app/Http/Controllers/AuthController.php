<?php namespace App\Http\Controllers;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\Models\LoginAttempts;
use App\Models\User;

use Illuminate\Http\Request;
use Auth;
use Hash;
use Input;
use Session;
use DB;

class AuthController extends Controller {

	public function Login(){
		$lg_attmpt = new \App\Models\LoginAttempts();
		if(Auth::attempt(Input::only('username','password'))){
			if(Auth::user()->active == 0)
			{
				Auth::logout();
				return ['success' => false, 'error' => 'You must activate your account first'];
			}
			else{
				$user = User::where('username', Input::get('username'))->first();
				if($user->is_locked == 0){
					$lg_attmpt->where('user_id', $user->id)->delete();
					/*Rajendra Added to update logged in status to 1*/
					DB::table('users')
					->where('id', Auth::user()->id)
					->update(array('is_logged_in' => 1));
					return ['success' => true, 'user' => Auth::user()];
				}
				else{
					$lg_exist = $lg_attmpt->where("user_id", $user->id)->first();
					if(!empty($lg_exist)){
						if($lg_exist->attempts > 2){
							$data = DB::select("SELECT attempts, (CASE when lastlogin is not NULL and DATE_ADD(lastlogin, INTERVAL 5 MINUTE)>'".date('Y-m-d H:i:s')."' then 1 else 0 end) as Denied FROM login_attempts WHERE user_id = ?", [$user->id]);
							if(!empty($data)){
								if($data[0]->Denied == 1){
									return ['success' => "locked", 'error' => 'Your account has been locked.'];
								}
								else if($data[0]->Denied == 0){
									$lg_attmpt->where('user_id', $user->id)->delete();
									DB::table('users')
									->where('id', Auth::user()->id)
									->update(array('is_logged_in' => 1, 'is_locked' => 0));
									return ['success' => true, 'user' => Auth::user()];
								}
							}
						}
						else{
							$lg_attmpt->where('user_id', $user->id)->delete();
							return ['success' => "locked", 'error' => 'Your account has been locked.'];
						}
					}
					else{
						return ['success' => "locked", 'error' => 'Your account has been locked.'];
					}
				}
			}
		}
		else{
			$user = User::where('username', Input::get('username'))->first();
			if(!empty($user) && $user->username == Input::get('username')){
				$data = $lg_attmpt->where("user_id", $user->id)->first();
				if($user->is_locked == 0){
					if($data){
						$attempts = $data["attempts"]+1;
						if($attempts > 2){
							$lg_attmpt->where('user_id', $user->id)->update(["attempts" => $attempts]);
							User::where('id', $user->id)->update(["is_locked" => 1]);
							return ['success' => "locked", 'error' => 'Your account has been locked.'];
						}
						else{
							$lg_attmpt->where('user_id', $user->id)->update(["attempts" => $attempts, 'lastlogin' => date('Y-m-d H:i:s')]);
						}
					}
					else{
						$lg_attmpt->user_id = $user->id;
						$lg_attmpt->attempts = 1;
						$lg_attmpt->lastlogin = date('Y-m-d H:i:s');
						$lg_attmpt->save();
					}
				}
				else{
					if($data){
						$attempts = $data["attempts"]+1;
						if($attempts > 2){
							$lg_attmpt->where('user_id', $user->id)->update(["attempts" => $attempts]);
						}
						else{
							$lg_attmpt->where('user_id', $user->id)->delete();
						}
					}
					return ['success' => "locked", 'error' => 'Your account has been locked.'];
				}
			}
			return ['success' => false, 'error' => 'The user name or password provided is incorrect.'];
		}
	}

	public Function Logout(){
	  /*Rajendra Added to update logged in status to 0*/
	  DB::table('users')
	  ->where('id', Auth::user()->id)
	  ->update(array('is_logged_in' => 0));
		Session::flush();
		Auth::logout();
		if (!Auth::check())
		{
			return redirect('/');
		}
	}

}
