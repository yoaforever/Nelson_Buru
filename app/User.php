<?php namespace App;

use Illuminate\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;

use App\Models\Customer;
use App\Models\SystemFunction;

class User extends Model implements AuthenticatableContract, CanResetPasswordContract {

	use Authenticatable, CanResetPassword;

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'users';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['username', 'email', 'password', 'role_id', 'customers_id, active'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = ['password', 'remember_token'];
	protected $dates = ['created_at', 'updated_at'];
	
	public function role() { return $this->belongsTo('App\Models\Role'); }

	public function customer() { return $this->belongsTo('App\Models\Customer', 'customers_id'); }

	public function system_functions() { return $this->belongsToMany('App\Models\SystemFunction', 'user_granted_functions')->withTimestamps(); }
}
