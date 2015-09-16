<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class BankAccountController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        //
        //to optain all countrys
        $bankaccounts = \App\Models\BankAccount::get();
        return response()->json([
                    "msg" => "Success",
                    "bankaccounts" => $bankaccounts->toArray()
                        ], 200
        );
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
    public function store(Request $request) {
        
        $bankaccounts=new \App\Models\BankAccount();
       // $input = Request::only('username','name','email','active','createdon','modifiedon','connections_id','image_profile', 'lastname');
        $bankaccounts->number =$request->number;
        $bankaccounts->name =$request->name;
        $bankaccounts->routing_number =$request->routing_number;
        $bankaccounts->save();
          
        return response()->json([
                    "msg" => "Success",
                    "id" => $bankaccounts->id,
                        ], 200
        );
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id) {
        //
      $bankaccounts = \App\Models\Customer::find($id);

        return Response::json($bankaccounts);
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
       $input = Input::all();

        $bankaccounts = \App\Models\Customer::find($id)->update($input);

        return Response::json($bankaccounts);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function destroy($id) {
        //
        $bankaccounts = \App\Models\Customer::destroy($id);

        return Response::json($bankaccounts);
        
    }

}
