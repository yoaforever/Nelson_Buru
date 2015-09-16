<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Input;
use App\Models\Customer;
use App\Models\CustomerFees;
use Response;
//use Input;
//use Validator; 
//use App\User;
//use Hash;
//use App\Models\UserActivationToken;
use Mail;
use App\Models\BankAccount;
use App\Models\User;
use DB;

class CompanyController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        $customers = \App\Models\Customer::all();

        return $customers;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create() {

//
    }

    public function search() {
//        $new = new \App\Models\Customer();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store() {

//
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

        $company_profile = Customer::find($id);
        $company_profile->legal_name = Input::get('legal_name');
        $company_profile->email = Input::get('email');
        $company_profile->address = Input::get('address');
        $company_profile->phone = Input::get('phone');
        $company_profile->active = Input::get('active');
		$company_profile->HQ_ID = Input::get('HQ_ID');
        if(Input::get('active') == 1){
             $company_profile->ach_id = 123;
        $company_profile->save();
		
            $data = array('email' => $company_profile->email, 'name' => $company_profile->legal_name, 'ach'=>$company_profile->ach_id);

            Mail::send('emails.activation_cs', array('name' => $data['name'], 'email' => $data['email'], 'ach'=> $data['ach']), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('Updated to PayAnyBiz!');
            });
            
            return Response::json([
                        'success' => true
                            ], 200);
        }
        else{
          $company_profile->save();  
           $data = array('email' => $company_profile->email, 'name' => $company_profile->legal_name, 'ach'=>$company_profile->ach_id);

            Mail::send('emails.updatedCompanyProfCS', array('name' => $data['name'], 'email' => $data['email'], 'ach'=> $data['ach']), function($message) use ($data) {
                $message->to($data['email'], $data['name'])->subject('Updated to PayAnyBiz!');
            });
               return Response::json([
                        'success' => true
                            ], 200);
         
        }
       
    }
	
	function company_fees() {
		$companyFeesIsExists = CustomerFees::where('customers_id', Input::get('customer_id'))->where('fee_type', Input::get('feeType'))->count();
		if($companyFeesIsExists) {
			$feesData = DB::table('customer_fees')->where('customers_id', Input::get('customer_id'))->where('fee_type', Input::get('feeType'))->first();
			$companyFees = CustomerFees::find($feesData->id);
			$companyFees->amount = Input::get('transactionFee');
			$companyFees->percentage = Input::get('percentage');
			$companyFees->updated_at = date('Y-m-d H:i:s');
			$companyFees->save();
			return Response::json(['success' => true], 200);
		}else {
			$companyfees = new CustomerFees;
			$companyfees->customers_id = Input::get('customer_id');
			$companyfees->fee_type = Input::get('feeType');
			$companyfees->amount = Input::get('transactionFee');
			$companyfees->percentage = Input::get('percentage');
			$companyfees->created_at = date('Y-m-d H:i:s');
			$companyfees->updated_at = date('Y-m-d H:i:s');
			$companyfees->save();
			return Response::json(['success' => true], 200);
		}
	}
	function fees_list($id) {
		return DB::table('customer_fees')->where('customers_id', $id)->get();
	}
	function set_customer_fee($id) {
		$customer = Customer::find($id);
		$customer->fee_type = Input::get('fee_type');
		$customer->save();
		return Response::json(['success' => true], 200);
	}
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function destroy($id) {
        //
    }

}
