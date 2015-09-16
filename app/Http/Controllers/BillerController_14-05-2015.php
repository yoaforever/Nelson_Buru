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
use App\Models\Transaction;
use App\Models\BillerActivationToken;
use App\Models\User;
use App\Models\City;
use App\Models\Role;
use App\Models\UserActivationToken;
use App\Models\CustomerRelation;
use Validator;

class BillerController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
       // $customers = \App\Models\Customer::all();
         $biller_customer = Customer::where('type_customer', 1)->get();

        return $biller_customer;
    }
    
       public function searchCustomerRelation($id){
        $payor_relations = array();
          $customer_relation = CustomerRelation::where('customers1_id', $id)->get();
         //$count = CustomerRelation::where('customers_id', $id)->count();
//          var_dump($count);
           $counta = 0;
           $biller_customer = Customer::all();
           //obtain the biller when the company  invited
          foreach ($customer_relation as $relation)
          { 
              foreach ($biller_customer as $payor) {
              if(($relation->customers_id == $payor->id) && ($payor->active ==1)){
                  
                 $payor_relations[$counta]= $payor; 
                 $counta= $counta + 1;
              }
              
          }
          }
          return $payor_relations;               
    }
    
     public function searchAllCustomerRelation($id){
        $payor_relations = array();
          $customer_relation = CustomerRelation::where('customers1_id', $id)->get();
         //$count = CustomerRelation::where('customers_id', $id)->count();
//          var_dump($count);
           $counta = 0;
           $biller_customer = Customer::all();
           //obtain the biller when the company  invited
          foreach ($customer_relation as $relation)
          { 
              foreach ($biller_customer as $payor) {
              if(($relation->customers_id == $payor->id)){
                  
                 $payor_relations[$counta]= $payor; 
                 $counta= $counta + 1;
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
        $new->address = Input::get('address');
        $new->zip_postal = Input::get('zip_postal');
        $new->country_id = Input::get('myCountry');
        $new->city_id = Input::get('myCity');
        $new->state_id = Input::get('myState');
        $new->active = 0;
        $new->type_customer = 1;
        $email = $new->email;
          //customer that invite
        $id_invite = Input::get('customer_current');
        $customer_invite = Customer::find($id_invite);
         $exist_customer = Customer::where('legal_name', $new->legal_name)->count();
        $exist_email = Customer::where('email', $new->email)->count();
        
        if ($exist_customer > 0 && $exist_email > 0) {
   
        $data = array('email' => $email, 'name' => $customer_invite->legal_name);
        Mail::send('emails.billerCreate', array('name' => $data['name'], 'email' => $data['email']), function($message) use ($data) {
            $message->to($data['email'], $data['name'])->subject('You have been invited to Join PayAnyBiz by ' . $data['name']);
        });
         return response()->json(['error' => true, 'legal_name_err' => 1, 'email_err' => 1], 400);
        } else if ($exist_email > 0) {
  
        $data = array('email' => $email, 'name' => $customer_invite->legal_name);
        Mail::send('emails.billerCreate', array('name' => $data['name'], 'email' => $data['email']), function($message) use ($data) {
            $message->to($data['email'], $data['name'])->subject('You have been invited to Join PayAnyBiz by ' . $data['name']);
        });
            return response()->json(['error' => true, 'email_err' => 1], 400);
        } else if ($exist_customer > 0 && $exist_email != 0) {
            return response()->json(['error' => true, 'legal_name_err' => 1], 400);
        } else {
        $new->save();
        $customer_id = $new->id;


        $new = new BankAccount;
        $new->number = Input::get('dAccountNumber');
        $new->routing_number = Input::get('dRoutingNumber');
        $new->active = 0;
        $new->customers_id = $customer_id;
        $new->type = BankAccount::TYPE_DEBIT;
        $new->bank_name = Input::get('dBankName');

        $new->save();

        $new = new BankAccount;
        $new->number = Input::get('cAccountNumber');
        $new->routing_number = Input::get('cRoutingNumber');
        $new->active = 0;
        $new->customers_id = $customer_id;
        $new->type = BankAccount::TYPE_CREDIT;
        $new->bank_name = Input::get('cBankName');

        $new->save();
        
        $customer_relation = new CustomerRelation;
        $customer_relation->customers_id = $customer_id; 
        $customer_relation->customers1_id = Input::get('customer_current');
        $customer_relation->active = 1;
        $customer_relation->save();

        
        //Create Activation token to activate the account
        $activation_token = new BillerActivationToken;
        $activation_token->biller_id = $customer_id;
        $activation_token->token = md5(uniqid(date('mdYhis'), true));

        $activation_token->save();

        $activation_url = url('/PayAnyBiz/ActivationBiller', ['token' => $activation_token->token]);

        $data = array('email' => $email, 'name' => $customer_invite->legal_name);

        Mail::send('emails.billerInvite', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
            $message->to($data['email'], $data['name'])->subject('You have been invited to Join PayAnyBiz by ' . $data['name']);
        });
        return Response::json([
                    'success' => true
                        ], 200);
        }
    }
    
    
    

    public function activateBiller($token) {
        $activation_token = BillerActivationToken::where('token', $token)->first();
        $biller_customer = Customer::where('id', $activation_token->biller_id)->first();
        $biller_banckdebit = BankAccount::where('customers_id', $biller_customer->id)->get();
        // $city = City::all();
        // $city = City::lists('name', 'id');
        $country = \App\Models\Country::lists('name', 'id');
        //var_dump($activation_token);
        if (!is_null($activation_token)) {
//			if($activation_token->isExpired() == true)
//				return Response::make("Token Expired", 200);

            return Response::view('registration.billerInvite', ['action' => 'activate', 'token_id' => $activation_token->id, 'legal_name' => $biller_customer->legal_name, 'email' => $biller_customer->email, 'biller_id' => $biller_customer->id, 'phone' => $biller_customer->phone, 'tin' => $biller_customer->tin,
                'dba' => $biller_customer->dba,'fax' => $biller_customer->fax, 'address' => $biller_customer->address, 'zip_postal' => $biller_customer->zip_postal, 'numberd' => $biller_banckdebit[0]->number,'numberc' => $biller_banckdebit[1]->number, 'routing_numberd' => $biller_banckdebit[0]->routing_number, 'routing_numberc' => $biller_banckdebit[1]->routing_number,
                'bank_named' => $biller_banckdebit[0]->bank_name, 'bank_namec' => $biller_banckdebit[1]->bank_name, 'token'=> $token]);
        }

        return Response::make("Not Found", 404);
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
        $biller = Customer::find($id);
        return Response::json([
                    'success' => true,
                    'biller' => $biller
                        ], 200);
    }
    
    
       public function listSortedBiller($id) {
        $txn =Transaction::find($id);
        $biller = Customer::find($txn->biller_id);
        $customer_relation = CustomerRelation::where('customers1_id', $txn->payor_id)->get();
        $biller_list = array();
        $counta = 1;
        $biller_list[0] = $biller;
        $all_billers = Customer::all();
        foreach ($customer_relation as $relation) {
            foreach ($all_billers as $billers) {

                if (($billers->id != $txn->biller_id) && ($relation->customers_id == $billers->id)) {

                    $biller_list[$counta] = $billers;
                    $counta = $counta + 1;
                }
            }
        }
        return $biller_list;
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
            'zip_postal' => array('required', 'regex:/^([0-9]{5})$/'),
            'phone' => array('required', 'regex:/^([0-9]{3})[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/'),
            'username' => 'between:6,25|unique:users,username',
            'fax' => array('regex:/^([0-9]{3})[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/'),
            'dba' => 'alpha_dash',
            'tin' => array('required', 'regex:/^([0-9]{2}-?[0-9]{9})$/'),
            'email' => 'required|unique:customers,email,' . $id . '',
            'dBankName' => 'required|between:2,25',
            'dAccountNumber' => array('required', 'regex:/^([0-9]{9,17})$/'),
            'dAccountNumberConfirm' => 'same:dAccountNumber',
            'dRoutingNumber' => array('required', 'regex:/^([0-9]{9})$/'),
            'dRoutingNumberConfirm' => 'same:dRoutingNumber',
            'cBankName' => 'required|between:2,25',
            'cAccountNumber' => array('required', 'regex:/^([0-9]{9,17})$/'),
            'cAccountNumberConfirm' => 'same:cAccountNumber',
            'cRoutingNumber' => array('required', 'regex:/^([0-9]{9})$/'),
            'cRoutingNumberConfirm' => 'same:cRoutingNumber'
        );

        $messages = array(
            'required' => 'This field is required',
            'legal_name.unique' => 'The legal name already exist',
            'email.unique' => 'The email already exist',
            'username.unique' => 'The username already exist',
            'zip_postal.required' => 'The zipcode is required.',
            'zip_postal.regex' => 'The :attribute format is invalid (5 digits).',
            'phone.regex' => 'The :attribute format is invalid (###-###-####).',
            'fax.regex' => 'The :attribute format is invalid (###-###-####).',
            'tin.regex' => 'The :attribute format is invalid (##-#########).',
            'dRoutingNumber.regex' => 'Invalid format (9 digits).',
            'cRoutingNumber.regex' => 'Invalid format (9 digits).',
            'cAccountNumber.regex' => 'Invalid format (9-17 digits).',
            'dAccountNumber.regex' => 'Invalid format (9-17 digits).',
            'between' => 'The :attribute must be between :min - :max.',
            'cRoutingNumberConfirm.same' => 'Routing Numbers must match',
            'dRoutingNumberConfirm.same' => 'Routing Numbers must match',
        );
        $token = Input::get('token');
        $validator = Validator::make(Input::all(), $rules, $messages);

        if ($validator->fails()) {
            return Redirect::to('/PayAnyBiz/ActivationBiller/' . $token)->withInput()->withErrors($validator);
        }
        

        $biller = Customer::find($id);
        // print_r($user->name);

        $biller->legal_name = Input::get('legal_name');
        $biller->dba = Input::get('dba');
        $biller->tin = Input::get('tin');
        $biller->email = Input::get('email');
        $biller->address = Input::get('address');
        $biller->zip_postal = Input::get('zip_postal');
        $biller->phone = Input::get('phone');

        $biller->fax = Input::get('fax');
        $biller->zip_postal = Input::get('zip_postal');
        $biller->country_id = Input::get('country');
        $biller->city_id = Input::get('city');
        $biller->state_id = Input::get('state');
        $biller->active = 1;
        $biller->save();
        $biller_id = $biller->id;

        $dbiller = new BankAccount;
        $dbiller->number = Input::get('dAccountNumber');
        $dbiller->routing_number = Input::get('dRoutingNumber');
        $dbiller->active = 0;
        $dbiller->customers_id = $biller_id;
        $dbiller->type = BankAccount::TYPE_DEBIT;
        $dbiller->bank_name = Input::get('dBankName');

        $dbiller->save();

        $cbiller = new BankAccount;
        $cbiller->number = Input::get('cAccountNumber');
        $cbiller->routing_number = Input::get('cRoutingNumber');
        $cbiller->active = 0;
        $cbiller->customers_id = $biller_id;
        $cbiller->type = BankAccount::TYPE_CREDIT;
        $cbiller->bank_name = Input::get('cBankName');

        $cbiller->save();

        //Create the user associated with the customer
        $user = new User;
        $user->username = Input::get('username');
        if ($user->username != null){
             $user->email = Input::get('email');
        $user->customers_id = $biller_id;
        $user->password = Hash::make($user->email);
        $user->active = 0;
        $user->role_id = 6;

        $user->save();

        //Create Activation token to activate the account
        $activation_token = new UserActivationToken;
        $activation_token->user_id = $user->id;
        $activation_token->token = md5(uniqid(date('mdYhis'), true));

        $activation_token->save();

        $activation_url = url('/PayAnyBiz/Activation', ['token' => $activation_token->token]);

        $data = array('email' => $user->email, 'name' => $biller->legal_name);

        Mail::send('emails.activation', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
            $message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
        });
        
        return Redirect::to('/');
        }
        else
        {
            
        return Redirect::to('/PayAnyBiz/ActivationBiller/' . $token)->with('message','You Are Now a Biller For ABC Company');    

        }
    }
    
    public function activateUser($token) 
	{
		$activation_token = UserActivationToken::where('token', $token)->first();

		if(!is_null($activation_token))
		{
			if($activation_token->isExpired() == true)
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
