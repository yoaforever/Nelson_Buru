<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\CustomerRelation;
use DB;

class CustomerRelationController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        //
        //to optain all countrys
        $customer_relation = \App\Models\CustomerRelation::get();
        return response()->json([
                    "msg" => "Success",
                    "bankaccounts" => $customer_relation->toArray()
                        ], 200
        );
    }

    public function countBillers() {
        $customer_relation = CustomerRelation::all();
        $list_biller = array();  
         $counta = 0;
        if($customer_relation != null){
             $counta = 1; 
        }
        foreach ($customer_relation as $relation) {
                $list_biller[$counta-1] = $relation->customers_id;
                $counta = $counta + 1;                
            }
     $result = array_unique($list_biller);
     return count($result);
    }

    public function countPayors() {
        $customer_relation = CustomerRelation::all();
        $list_payor = array();  
         $counta = 0;
        if($customer_relation != null){
             $counta = 1; 
        }
        foreach ($customer_relation as $relation) {
                $list_payor[$counta-1] = $relation->customers1_id;
                $counta = $counta + 1;                
            }
     $result = array_unique($list_payor);
     return count($result);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create() {
        // 
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
        //
//      $bankaccounts = \App\Models\Customer::find($id);
//
//        return Response::json($bankaccounts);
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
        //
//       $input = Input::all();
//
//        $bankaccounts = \App\Models\Customer::find($id)->update($input);
//
//        return Response::json($bankaccounts);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function destroy($id) {
        //
//        $bankaccounts = \App\Models\Customer::destroy($id);
//
//        return Response::json($bankaccounts);
    }

}
