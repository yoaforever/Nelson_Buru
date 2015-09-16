<?php

namespace App\Http\Controllers;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Response;
use Input;
use Validator;
use App\Models\Customer;
use App\Models\UsersIp;
use App\User;
use Hash;
use Mail;
use App\Models\UserActivationToken;
use App\Models\BankAccount;
use App\Models\Role;
use Crypt;

class RegistrationController extends Controller {

  /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function register() {
        
		$rules = [
            'companyName' => 'required|between:2,25|unique:customers,legal_name',
            'address' => 'required|between:2,50',
            'city' => array('required', 'regex:/^([A-Za-z ]+)$/'),
            'state' => 'required',
            'zipcode' => array('required', 'regex:/^([0-9]{3,5})$/'),
            'phone' => array('required', 'regex:/^([0-9]{3})[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/'),
            'phoneExt' => 'numeric',
            'fax' => array('regex:/^([0-9]{3})[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/'),
            'dba' => 'alpha_dash',
            'tin' => array('required', 'regex:/^([0-9]{2}-?[0-9]{9})$/'),
            'duns' => 'numeric',
            'email' => 'required|email|unique:users',
            'dBankName' => 'required|between:2,25',
            'dAccountNumber' => 'required|numeric|between:4,17',
            'dAccountNumberConfirm' => 'same:dAccountNumber',
            'dRoutingNumber' => array('required', 'regex:/^([0-9]{9})$/'),
            'dRoutingNumberConfirm' => 'same:dRoutingNumber',
            'cBankName' => 'required|between:2,25',
            'cAccountNumber' => 'required|numeric|between:4,17',
            'cAccountNumberConfirm' => 'same:cAccountNumber',
            'cRoutingNumber' => array('required', 'regex:/^([0-9]{9})$/'),
            'cRoutingNumberConfirm' => 'same:cRoutingNumber',
            'name' => 'required|between:2,25',
            'lastname' => 'required|between:2,25',
            'username' => 'required|between:6,25|unique:users',
            'agree' => 'accepted'
        ];

        $messages = [
            'required' => 'This field is required',
            'city.regex' => 'The :attribute format is invalid (letters only).',
            'city.required' => 'The city is required.',
            'zipcode.required' => 'The zipcode is required.',
            'zipcode.regex' => 'The :attribute format is invalid (3-5 digits).',
            'phone.regex' => 'The :attribute format is invalid (###-###-####).',
            'fax.regex' => 'The :attribute format is invalid (###-###-####).',
            'tin.regex' => 'The :attribute format is invalid (##-#########).',
            'dRoutingNumber.regex' => 'Invalid format (9 digits).',
            'cRoutingNumber.regex' => 'Invalid format (9 digits).',
            'between' => 'The :attribute must be between :min - :max.',
            'agree.accepted' => 'You must accept the terms and conditions',
            'cRoutingNumberConfirm.same' => 'Routing Numbers must match',
            'dRoutingNumberConfirm.same' => 'Routing Numbers must match',
        ];

        $validator = Validator::make(Input::all(), $rules, $messages);

        if ($validator->fails()) {
            return Response::json([
                        'success' => false,
                        'error' => $validator->messages(),
                            ], 200);
        }

        $customer = new Customer;
        $customer->legal_name = Input::get('companyName');
        $customer->dba = Input::get('dba');
        $customer->tin = Input::get('tin');
        $customer->address = Input::get('address');
        $customer->zip_postal = Input::get('zipcode');
        $customer->phone = Input::get('phone');
        $customer->phone_ext = Input::get('phone_ext');
        $customer->fax = Input::get('fax');
        $customer->email = Input::get('email');
        $customer->country_id = Input::get('country', 1);
        $customer->city = Input::get('city');
        $customer->duns = Input::get('duns');
        $customer->state_id = Input::get('state');
        $customer->active = 0;

        $customer->save();

        //Create customer's bank accounts
        $account = new BankAccount;
        $account->number = Input::get('dAccountNumber');
        $account->routing_number = Input::get('dRoutingNumber');
        $account->active = 0;
        $account->customers_id = $customer->id;
        $account->type = BankAccount::TYPE_DEBIT;
        $account->bank_name = Input::get('dBankName');

        $account->save();

        $account = new BankAccount;
        $account->number = Input::get('cAccountNumber');
        $account->routing_number = Input::get('cRoutingNumber');
        $account->active = 0;
        $account->customers_id = $customer->id;
        $account->type = BankAccount::TYPE_CREDIT;
        $account->bank_name = Input::get('cBankName');

        $account->save();

        //Create the user associated with the customer
        $user = new User;
        $user->name = Input::get('name');
        $user->lastname = Input::get('lastname');
        $user->username = Input::get('username');
        $user->email = Input::get('email');
        $user->customers_id = $customer->id;
        $user->password = Hash::make($user->email);
        $user->active = 0;
        $user->role_id = 5;

        $user->save();
		
		$userIp = new UsersIp;
		$userIp->user_id = $user->id;
		$userIp->ip_address = $_SERVER['REMOTE_ADDR'];
		$userIp->status = 1;
		$userIp->token = '';
		$userIp->updated_at = date('Y-m-d H:i:s');
		$userIp->created_at = date('Y-m-d H:i:s');
		$userIp->save();
		
        //Create Activation token to activate the account
        $activation_token = new UserActivationToken;
        $activation_token->user_id = $user->id;
        $activation_token->token = md5(uniqid(date('mdYhis'), true));

        $activation_token->save();

        $activation_url = url('/PayAnyBiz/Activation', ['token' => $activation_token->token]);

        $data = array('email' => $user->email, 'name' => $customer->legal_name);

        Mail::send('emails.activation', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
            $message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
        });

        return Response::json([
                    'success' => true
                        ], 200);
    }

    public function activate($token) {
        $activation_token = UserActivationToken::where('token', $token)->first();

        if (!is_null($activation_token)) {
            if ($activation_token->isExpired() == true)
                return Response::make("Token Expired", 200);

            return Response::view('registration.activation', ['action' => 'activate', 'token_id' => $activation_token->id]);
        }

        return Response::make("Not Found", 404);
    }

    public function resetPassword() {

        try {
            $errors = [];
//            $messages = array(
//                'required' => 'The password is required',
//                'between' => 'The :attribute must be between :min - :max.',
//                'password.regex' => 'The password is not strong',
//                'same'    => 'The :attribute and :other must match.',);
            $validator = Validator::make(Input::all(), [
                        'password' => array('required', 'between:8,16', 'regex:/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}$/'),
                        'password_confirmation' => array('required','same:password') ,
            ]);

            if ($validator->fails()) {
                 $errors = $validator->messages();
            } else {
                $activ_token = UserActivationToken::find(Input::get('token_id'));
                $user = $activ_token->user;

                $user->active = 1;
                $user->password = Hash::make(Input::get('password'));
                $user->passw_decrypt = Crypt::encrypt(Input::get('password'));
                $user->date_password_changed = date('Y-m-d');
                $user->attempts_daily = 0;
                $user->save();

                $activ_token->delete();

                return Response::view('registration.success');
            }

            return Response::view('registration.activation', ['action' => Input::get('action', 'activate'), 'token_id' => Input::get('token_id'), 'errors' => $errors]);
        } catch (Exception $e) {
            return Response::make($e->getMessage(), 500);
        }
    }

    public function passwordRecovery() {
        $validator = Validator::make(Input::all(), ['email' => 'required|email|exists:users']);

        if ($validator->fails()) {
            return Response::json([
                        'success' => false,
                        'error' => $validator->messages(),
                            ], 200);
        }

        $users = User::where('email', Input::get('email'))->get();

        foreach ($users as $user) {
            $token = md5(uniqid(date('mdYhis'), true));
            $activation_url = url('/PayAnyBiz/Activation', ['token' => $token]);
            $user->url = $activation_url;

            $activation_token = new UserActivationToken;
            $activation_token->user_id = $user->id;
            $activation_token->token = $token;
            $activation_token->save();
        }

        $data = array('email' => Input::get('email'), 'users' => $users);

        Mail::send('emails.recovery', array('users' => $users, 'email' => $data['email']), function($message) use ($data) {
            $message->to($data['email'], 'PayAnyBiz Customer')->subject('PayAnyBiz Password Recovery!');
        });

        return Response::json([
                    'success' => true
                        ], 200);
    }

}
