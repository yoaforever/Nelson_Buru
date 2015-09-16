<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class RoleUser extends Model  {




	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'role_user';

	const ROLE_ADMIN = 1;
	const ROLE_COMPANY = 2;
	const ROLE_EMPLOYEE = 3;	

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['user_id','role_id'];


//
//
//	public function system_functions() { return $this->belongsToMany('App\Models\SystemFunction', 'role_granted_functions')->withTimestamps(); }
}
