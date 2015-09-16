<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Input;

class UserController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        //
        //to optain all countrys
        $users = \App\Models\User::get();
        return response()->json([
                    "msg" => "Success",
                    "users" => $users->toArray()
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
        
        $users=new \App\Models\User();
       // $input = Request::only('username','name','email','active','createdon','modifiedon','connections_id','image_profile', 'lastname');
        $users->name =$request->name;
        $users->username =$request->username;
        $users->email =$request->email;
        $users->active =$request->active;
        $users->lastname =$request->lastname;
        $users->save();
          
        return response()->json([
                    "msg" => "Success",
                    "id" => $users->id,
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
        $users = \App\Models\User::find($id);
       
//        return Response::json($users);
         return response()->json([
                    "msg" => "Success",
                     "id" => $users->id,
                        ], 200
        );
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
    public function update(Request $request, $id) {
        //
       $users = \App\Models\User::find($id);
        $users->name =$request->name;
       // $users->username =$request->username;
       $users->username= $request->username;
        $users->email =$request->email;
        $users->active =$request->active;
        $users->lastname =$request->lastname;
        $users->save();

         return response()->json([
                    "msg" => "Success",
                    "users" => $users,
                        ], 200
        );
         

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

}
