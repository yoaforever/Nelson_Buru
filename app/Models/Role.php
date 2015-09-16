<?php namespace App\Models;


use Zizaco\Entrust\EntrustRole;

class Role extends EntrustRole  {


	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'roles';

	const ROLE_ADMIN = 1;
	const ROLE_COMPANY = 2;
	const ROLE_EMPLOYEE = 3;	

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['name','display_name','description','created_at','updated_at'];

//	protected $dates = ['created_at', 'updated_at', 'deleted_at'];
//
	public function users() { return $this->hasMany('User'); }
        public function permissions() { return $this->hasMany('Permissions'); }
//
//	public function system_functions() { return $this->belongsToMany('App\Models\SystemFunction', 'role_granted_functions')->withTimestamps(); }
}
