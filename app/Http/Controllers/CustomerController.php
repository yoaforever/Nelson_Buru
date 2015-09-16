<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Input;
use App\Models\Customer;
use Response;
use App\Models\BankAccount;
use Mail;
use DB;
use App\Models\User;

class CustomerController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        $customers = \App\Models\Customer::all();
        return $customers;
    }

    
    public function countCustomers() {
        $customers = DB::table('customers')->count();
        return $customers;
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create() {

        $new = new \App\Models\Customer();
        $new->legal_name = Input::get('legal_name');
        $new->dba = Input::get('dba');
        $new->tin = Input::get('tin');
        $new->address = Input::get('address');
        $new->zip_postal = Input::get('zip_postal');
        $new->phone = Input::get('phone');
        $new->fax = Input::get('fax');
        $new->email = Input::get('email');
        $new->country_id = Input::get('myCountry');
        $new->city_id = Input::get('myCity');
        $new->state_id = Input::get('myState');
        // $customer_id=$new->id;
        $new->save();
        $customer_id = $new->id;
        //  var_dump($customer_id);
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

        return Response::json([
                    'success' => true
                        ], 200);
    }

    public function search() {

        $legal_name = Input::get('legalNameCol');
        $customers = DB::table('customers')
                ->where('legal_name', '=', $legal_name)
                ->get();
        return $customers;
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
        return Customer::find($id);
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

        $customer = Customer::find($id);
        // print_r($user->name);
        $customer->legal_name = Input::get('legal_name');
        // var_dump($user->name);
        $customer->dba = Input::get('dba');
        $customer->tin = Input::get('tin');
        $customer->email = Input::get('email');
        $customer->address = Input::get('address');
        $customer->zip_postal = Input::get('zip_postal');
        $customer->phone = Input::get('phone');
        $customer->fax = Input::get('fax');
         
        $customer->active = 1;

        $state =Input::get('state_id');
        $cities = Input::get('city_id');
        $country = Input::get('country_id');
        if($state != '' && $cities!='' ){
         $customer->city_id = Input::get('city_id');
        $customer->state_id = Input::get('state_id');

        }
        if($country!=''){
                   $customer->country_id = Input::get('country_id'); 
        }
               
        $exist_name = Customer::where('legal_name', $customer->legal_name)->count();
        $exist_legal_name = Customer::where('legal_name', $customer->legal_name)->get();
        $exist_email = Customer::where('email', $customer->email)->count();
        $exist_email_id = Customer::where('email', $customer->email)->get();
        if (($exist_name >= 1 && $exist_legal_name[0]->id != $id) && ($exist_email >= 1 && $exist_email_id[0]->id != $id)) {
          //  $count = $count + 1;
            return response()->json(['error' => true, 'username_err' => 1, 'email_err' => 1], 400);
        } elseif ($exist_email >= 1 && $exist_email_id[0]->id != $id) {
           // $count = $count + 1;
            return response()->json(['error' => true, 'email_err' => 1], 400);
        } elseif ($exist_name >= 1 && $exist_legal_name[0]->id != $id) {
          //  $count = $count + 1;
            return response()->json(['error' => true, 'username_err' => 1], 400);
        }else  {
            $customer->save();
            $customer_invite = "PayAnyBiz";
            $data = array('email' => $customer->email, 'name' => $customer_invite);

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
        $customers = \App\Models\Customer::destroy($id);

        return Response::json($customers);
    }
    /**
     * get Customer's bank info
     *
     * @param int $id
     * @author: Rajendra
     * */
     
    public function getBankInfo($id)
    {
      $customer = DB::table('customers')
      ->select('customers.*','users.id as userid','users.name as firstname','users.is_logged_in','users.lastname','users.email',
          'countrys.name as countryname','citys.name as cityname', 'states.name as statename')
          ->join('users', function($join){
            $join->on('users.customers_id', '=', 'customers.id');
          })
          ->leftjoin('countrys', function($join){
            $join->on('countrys.id', '=', 'customers.country_id');
          })
          ->leftjoin('citys', function($join){
            $join->on('citys.id', '=', 'customers.city_id');
          })
          ->leftjoin('states', function($join){
            $join->on('states.id', '=', 'customers.state_id');
          })
          ->where('customers.id' ,'=', $id)
          ->get(); 
          $banks = BankAccount::where('customers_id', '=', $id)->get();  
          foreach($banks as $bank){
            if($bank->type == 2)
              $customer[0]->creditaccount = $bank->getAttributes();
            else if($bank->type == 1)
              $customer[0]->debitaccount = $bank->getAttributes();
          }
          return Response::json([
              'customer' => $customer[0]
              ], 200);
    }
    /**
	     * Update Customer's bank info
	     * @param int $id - Customer Id
	     * @param array $data - Form submitted data
	     * @author: Rajendra
	* */
    public function updateCustomerBankInfo($id)
    {
      $customer = Customer::find($id);
	  
      $customer->legal_name = trim(Input::get('legal_name'));
      $customer->tin = trim(Input::get('tin'));
      $customer->email = trim(Input::get('email'));
      $customer->address = trim(Input::get('address'));
      $customer->zip_postal = trim(Input::get('zip_postal'));
      $customer->phone = trim(Input::get('phone'));
      $cityselected = Input::get('citySelected');
      $stateselected = Input::get('stateSelected');
      $countryselected = Input::get('countrySelected');
      $customer->country_id = $countryselected['id'];
      $customer->city_id = $cityselected['id'];
      $customer->state_id = $stateselected['id'];
	  
      $user = User::find(Input::get('userid'));
      $user->name = trim(Input::get('firstname'));
      $user->lastname = trim(Input::get('lastname'));
      $user->email =  trim(Input::get('email'));
      $customer->save();
      $user->save();
	  
      $customer_id = $id;
      $debitaccount = Input::get('debitaccount');
      $creditaccount = Input::get('creditaccount');
      $debit = BankAccount::find($debitaccount['id']);
      $debit->number = trim($debitaccount['number']);
      $debit->routing_number = trim($debitaccount['routing_number']);
      $debit->customers_id = $customer_id;
      $debit->type = BankAccount::TYPE_DEBIT;
      $debit->bank_name = trim($debitaccount['bank_name']);
      $debit->save();
	  
      $credit = BankAccount::find($creditaccount['id']);
      $credit->number = trim($creditaccount['number']);
      $credit->routing_number = trim($creditaccount['routing_number']);
      $credit->customers_id = $customer_id;
      $credit->type = BankAccount::TYPE_CREDIT;
      $credit->bank_name = trim($creditaccount['bank_name']);
      $credit->save();
      return Response::json(['success' => true], 200);
    }
}
