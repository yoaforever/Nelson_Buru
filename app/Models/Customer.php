<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class Customer extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'customers';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['legal_name','dba','tin','address', 'zip_postal', 'phone','phone_ext','fax','email','url','debit_account_id','ofac_status','registration_status','created_at','updated_at','active','country_id','city_id','state_id','duns','city' ];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];
 	//public $timestamps = false;

}
