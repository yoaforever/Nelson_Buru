<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Input;
use App\Models\Customer;
use Response;
use Mail;
use Hash;
use Illuminate\Support\Facades\Redirect;
use App\Models\BankAccount;
use App\Models\PayorActivationToken;
use App\Models\User;
use App\Models\City;
use App\Models\Role;
use App\Models\UserActivationToken;
use App\Models\CustomerRelation;
use App\Models\Transaction;
use Validator;

class PayorController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        $payor_customer = Customer::where('type_customer', 0)->get();

        return $payor_customer;
    }

    public function searchCustomerRelation($id) {
        $payor_relations = array();
        $customer_relation = CustomerRelation::where('customers_id', $id)->get();
        $counta = 0;
        $biller_customer = Customer::all();
        //obtain the biller when the company  invited
        foreach ($customer_relation as $relation) {
            foreach ($biller_customer as $payor) {
                if (($relation->customers1_id == $payor->id) && ($relation->active == 1)) {

                    $payor_relations[$counta] = $payor;
                    $counta = $counta + 1;
                }
            }
        }

        return $payor_relations;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create() {

        $new = new \App\Models\Customer();
        $new->legal_name = Input::get('legal_name');
        $new->email = Input::get('email');
        $new->phone = Input::get('phone');
        $new->dba = Input::get('dba');
        $new->tin = Input::get('tin');
        $new->fax = Input::get('fax');
        $new->active = 0;
        $new->type_customer = 0;

        //customer that invite
        $id_invite = Input::get('customer_current');
        $customer_invite = Customer::find($id_invite);

        $exist_customer = Customer::where('legal_name', $new->legal_name)->count();
        $exist_email = Customer::where('email', $new->email)->count();
        $exist_payor = Customer::where('email', $new->email)->first();

        
          if ($exist_customer > 0 && $exist_email > 0) {
              $count =0;
            $payors = CustomerRelation::all();
            foreach ($payors as $relations){
                if($relations->customers1_id == $exist_payor->id && $relations->customers_id == $id_invite){
                    $count =1;
                }
            }
            $data = array('email' => $customer_invite->email, 'name' => $exist_payor->legal_name, 'payor' => $customer_invite->legal_name);

            Mail::send('emails.relation_payor_exist', array('name' => $data['name'], 'email' => $data['email'], 'payor' => $data['payor']), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('You are already connected to ' . $data['name']);
            });
            return response()->json(['error' => true, 'legal_name_err' => 2, 'email_err' => 2], 400);
        }
        if ($exist_customer > 0 && $exist_email > 0) {
            $payors = new CustomerRelation();
            $payors->customers1_id = $exist_payor->id;
            $payors->customers_id = $id_invite;
            $payors->active = 0;
            $payors->save();
            $activation_url = url('/PayAnyBiz/ConnectPayor', ['id' => $payors->id]);
            $data = array('email' => $exist_payor->email, 'name' => $exist_payor->legal_name, 'payor' => $customer_invite->legal_name, 'relation_id' => $payors->id);

            Mail::send('emails.connect_payor_exist', array('name' => $data['name'], 'email' => $data['email'], 'payor' => $data['payor'], 'relation_id' => $data['relation_id'], 'url' => $activation_url), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('You have been connected as Payor  by ' . $data['payor']);
            });
            return response()->json(['error' => true, 'legal_name_err' => 1, 'email_err' => 1], 400);
        } elseif ($exist_email > 0) {
           $payors = new CustomerRelation();
            $payors->customers1_id = $exist_payor->id;
            $payors->customers_id = $id_invite;
            $payors->active = 0;
            $payors->save();
            $activation_url = url('/PayAnyBiz/ConnectPayor', ['id' => $payors->id]);
            $data = array('email' => $exist_payor->email, 'name' => $exist_payor->legal_name, 'payor' => $customer_invite->legal_name, 'relation_id' => $payors->id);

            Mail::send('emails.connect_payor_exist', array('name' => $data['name'], 'email' => $data['email'], 'payor' => $data['payor'], 'relation_id' => $data['relation_id'], 'url' => $activation_url), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('You have been connected as Payor  by ' . $data['payor']);
            });
            return response()->json(['error' => true, 'email_err' => 1], 400);
        } elseif ($exist_customer > 0) {
            return response()->json(['error' => true, 'legal_name_err' => 1], 400);
        } else {
            $new->save();
            $customer_id = $new->id;

            //created asosiation between payor and biller
            $customer_relation = new CustomerRelation;
            $customer_relation->customers_id = Input::get('customer_current');
            $customer_relation->customers1_id = $customer_id;
            $customer_relation->active = 0;
            $customer_relation->save();

//        $user_customer = User::where('customers_id' ,$customer_id)->first();
//        var_dump($user_customer->id);
            //Create Activation token to activate the account
            $activation_token = new PayorActivationToken;
            $activation_token->payor_id = $customer_id;
            $activation_token->token = md5(uniqid(date('mdYhis'), true));

            $activation_token->save();

            $activation_url = url('/PayAnyBiz/ActivationPayor', ['token' => $activation_token->token]);

            $data = array('email' => $new->email, 'name' => $customer_invite->legal_name);

            Mail::send('emails.payorInvite', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('You have been invited to Join PayAnyBiz by ' . $data['name']);
            });
            return Response::json([
                        'success' => true
                            ], 200);
        }
    }

    public function activatePayor($token) {
        $activation_token = PayorActivationToken::where('token', $token)->first();
        $payor_customer = Customer::where('id', $activation_token->payor_id)->first();
        $country = \App\Models\Country::lists('name', 'id');
        //var_dump($activation_token);
        if (!is_null($activation_token)) {
//			if($activation_token->isExpired() == true)
//				return Response::make("Token Expired", 200);

            return Response::view('registration.payorInvite', ['action' => 'activate', 'token_id' => $activation_token->id, 'token' => $activation_token->token, 'legal_name' => $payor_customer->legal_name, 'email' => $payor_customer->email, 'payor_id' => $payor_customer->id, 'phone' => $payor_customer->phone, 'tin' => $payor_customer->tin, 'dba' => $payor_customer->dba, 'fax' => $payor_customer->fax]);
        }

        return Response::make("Not Found", 404);
    }

    public function updateConnectPayor($id) {
        $customer_relation = CustomerRelation::where('id', $id)->first();
        $customer_relation->active = 1;
        $customer_relation->save();
        $customer_invite = Customer::where('id', $customer_relation->customers_id)->first();
        $payor = Customer::where('id', $customer_relation->customers1_id)->first();
        $data = array('email' => $customer_invite->email, 'name' => $customer_invite->legal_name, 'payor' => $payor->legal_name);

        Mail::send('emails.connection_payor_accepted', array('name' => $data['name'], 'email' => $data['email'], 'payor' => $data['payor']), function($message) use ($data) {
            $message->to($data['email'], $data['name'])->subject('You have been accepted as Biller  by ' . $data['payor']);
        });
//        return Response::json([
//                    'success' => true
//                        ], 200);
          return Response::view('registration.payorConnect',  array('name' => $data['name']));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store(Request $request) {
        
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id) {
        $payor = Customer::find($id);
        return Response::json([
                    'success' => true,
                    'payor' => $payor
                        ], 200);
    }

    //shows the list with the selected first payor
    public function listSortedPayor($id) {
        $txn = Transaction::find($id);
        $payor = Customer::find($txn->payor_id);
        $customer_relation = CustomerRelation::where('customers_id', $txn->biller_id)->get();
        $payor_list = array();
        $counta = 1;
        $payor_list[0] = $payor;
        $all_payors = Customer::all();
        foreach ($customer_relation as $relation) {
            foreach ($all_payors as $payors) {

                if (($payors->id != $txn->payor_id) && ($relation->customers1_id == $payors->id)) {

                    $payor_list[$counta] = $payors;
                    $counta = $counta + 1;
                }
            }
        }
        return $payor_list;
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
        $rules = array(
            'legal_name' => 'required|between:2,25|unique:customers,legal_name,' . $id . '',
            'address' => 'required|between:2,50',
            'zip_postal' => array('required', 'regex:/^([0-9]{3,5})$/'),
            'phone' => array('required', 'regex:/^([0-9]{3})[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/'),
            'username' => array('required', 'between:6,25', 'unique:users,username', 'regex:/^[a-zA-Z0-9_]{6,25}$/'),
            'fax' => array('regex:/^([0-9]{3})[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/'),
            'dba' => 'alpha_dash',
            'tin' => array('required', 'regex:/^([0-9]{2}-?[0-9]{7})$/'),
            'email' => 'required|unique:customers,email,' . $id . '',
            'dBankName' => 'required|between:2,25',
            'dAccountNumber' => array('required', 'regex:/^([0-9]{4,17})$/'),
            'dAccountNumberConfirm' => 'same:dAccountNumber',
            'dRoutingNumber' => array('required', 'regex:/^([0-9]{9})$/'),
            'dRoutingNumberConfirm' => 'same:dRoutingNumber',
            'cBankName' => 'required|between:2,25',
            'cAccountNumber' => array('required', 'regex:/^([0-9]{4,17})$/'),
            'cAccountNumberConfirm' => 'same:cAccountNumber',
            'cRoutingNumber' => array('required', 'regex:/^([0-9]{9})$/'),
            'cRoutingNumberConfirm' => 'same:cRoutingNumber'
        );

        $messages = array(
            'required' => 'This field is required',
            'legal_name.unique' => 'The legal name already exist',
            'email.unique' => 'The email already exist',
            'username.unique' => 'The username already exist',
            'username.regex' => 'The :attribute format is invalid (6 - 25 digits).',
            'zip_postal.required' => 'The zipcode is required.',
            'zip_postal.regex' => 'The :attribute format is invalid (3-5 digits).',
            'phone.regex' => 'The :attribute format is invalid (###-###-####).',
            'fax.regex' => 'The :attribute format is invalid (###-###-####).',
            'tin.regex' => 'The :attribute format is invalid (##-#######).',
            'dRoutingNumber.regex' => 'Invalid format (9 digits).',
            'cRoutingNumber.regex' => 'Invalid format (9 digits).',
            'cAccountNumber.regex' => 'Invalid format (4-17 digits).',
            'dAccountNumber.regex' => 'Invalid format (4-17 digits).',
            'between' => 'The :attribute must be between :min - :max.',
            'cRoutingNumberConfirm.same' => 'Routing Numbers must match',
            'dRoutingNumberConfirm.same' => 'Routing Numbers must match',
        );
        $token = Input::get('token');
        $validator = Validator::make(Input::all(), $rules, $messages);

        if ($validator->fails()) {
            return Redirect::to('/PayAnyBiz/ActivationPayor/' . $token)->withInput()->withErrors($validator);
//			return Response::json([
//									'success' => false,
//									'error' => $validator->messages(),
//								], 200);
        }


        $payor = Customer::find($id);
        // print_r($user->name);

        $payor->legal_name = Input::get('legal_name');
        $payor->dba = Input::get('dba');
        $payor->tin = Input::get('tin');
        $payor->email = Input::get('email');
        $payor->address = Input::get('address');
        $payor->zip_postal = Input::get('zip_postal');
        $payor->phone = Input::get('phone');

        $payor->fax = Input::get('fax');
        $payor->zip_postal = Input::get('zip_postal');
        $payor->country_id = Input::get('country');
        $payor->city_id = Input::get('city');
        $payor->state_id = Input::get('state');
        $payor->active = 1;
        $payor->save();
        $payor_id = $payor->id;

        $customer_relation = CustomerRelation::where('customers1_id', $payor_id)->first();
        $customer_relation->active = 1;
        $customer_relation->save();

        $dpayor = new BankAccount;
        $dpayor->number = Input::get('dAccountNumber');
        $dpayor->routing_number = Input::get('dRoutingNumber');
        $dpayor->active = 0;
        $dpayor->customers_id = $payor_id;
        $dpayor->type = BankAccount::TYPE_DEBIT;
        $dpayor->bank_name = Input::get('dBankName');

        $dpayor->save();

        $cpayor = new BankAccount;
        $cpayor->number = Input::get('cAccountNumber');
        $cpayor->routing_number = Input::get('cRoutingNumber');
        $cpayor->active = 0;
        $cpayor->customers_id = $payor_id;
        $cpayor->type = BankAccount::TYPE_CREDIT;
        $cpayor->bank_name = Input::get('cBankName');

        $cpayor->save();

        //Create the user associated with the customer
        $user = new User;
        $user->username = Input::get('username');
        $user->email = Input::get('email');
        $user->customers_id = $payor_id;
        $user->password = Hash::make($user->email);
        $user->active = 0;
        $user->role_id = 7;
        $user->save();


        //  Create Activation token to activate the account
        $activation_token = new UserActivationToken;
        $activation_token->user_id = $user->id;
        $activation_token->token = md5(uniqid(date('mdYhis'), true));

        $activation_token->save();

        $activation_url = url('/PayAnyBiz/Activation', ['token' => $activation_token->token]);

        $data = array('email' => $user->email, 'name' => $payor->legal_name);

        Mail::send('emails.activation', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
            $message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
        });

        return Redirect::to('/');

//        return Response::json([
//                    'success' => true
//                        ], 200);
    }

    public function activateUser($token) {
        $activation_token = UserActivationToken::where('token', $token)->first();

        if (!is_null($activation_token)) {
            if ($activation_token->isExpired() == true)
                return Response::make("Token Expired", 200);

            return Response::view('registration.activation', ['action' => 'activate', 'token_id' => $activation_token->id]);
        }

        return Response::make("Not Found", 404);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function destroy($id) {
        //
        $customers = \App\Models\Customer::destroy($id);

        return Response::json($customers);
    }

}
