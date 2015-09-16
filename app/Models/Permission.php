<?php namespace App\Models;


use Zizaco\Entrust\EntrustPermission;

class Permission extends EntrustPermission  {




	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'permissions';

	const ROLE_ADMIN = 1;
	const ROLE_COMPANY = 2;
	const ROLE_EMPLOYEE = 3;	

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['name','display_name','description','created_at','updated_at'];


//
	public function roles() { return $this->belongsTo('Role'); }
//
//	public function system_functions() { return $this->belongsToMany('App\Models\SystemFunction', 'role_granted_functions')->withTimestamps(); }
}
