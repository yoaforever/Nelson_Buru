<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class RegistrationQueue extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'registrationqueues';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['created_at', 'updated_at', 'requestip','status', 'processed', 'users_id','customers_id','active'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];

}
