<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Redirect;
use App\Models\Role;
use App\Models\Permission;
use App\Models\PermissionRole;


class RoleController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        $roles = Role::all();
        $all_without_cs = array();
        $count = 0;
        $last = $roles->last();
        foreach ($roles as $rol)
        {
          //if($rol->id != $last->id){
		  if($rol->id != 8){
            $all_without_cs[$count] = $rol; 
            $count = $count + 1;
          }  
        }
        return $all_without_cs;
    }
    
    
     public function searchPermissoRole($id) {
        $permissions_roles = PermissionRole::find($id);
        foreach ($permissions_roles as $perm_role){
            $permission_role = Permission::where('id', $perm_role->permission_id)->get(); 
        }
        return $permission_role;
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
        
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id) {
		$roles = Role::find($id);
		return $roles;
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
