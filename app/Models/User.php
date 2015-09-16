<?php namespace App\Models;


use Illuminate\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;
use Zizaco\Entrust\Traits\EntrustUserTrait;


class User extends Model implements AuthenticatableContract, CanResetPasswordContract {

	use Authenticatable, CanResetPassword; 
        use EntrustUserTrait;


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
	protected $fillable = ['username','name','email', 'active', 'created_at','updated_at','customers_id','connections_id','image_profile','lastname','password' ];
        protected $dates = ['created_at', 'updated_at'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = ['password', 'remember_token'];
        public function roles() { return $this->belongsTo('Role'); }
//        public function isExpired(){
//
//		return Carbon::now()->gte($this->created_at->addDay());
//	}
        
       // public $timestamps = false;
        
    /*     protected function getDateFormat()
    {
        return 'U';
    }*/

}
