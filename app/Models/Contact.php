<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class Contact extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'contacts';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['first_name','last_name','address','zip_postal', 'phone', 'phone_ext','fax','email','createdon','modifiedon','active','country_id','customers_id','state_id','city_id' ];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];

}
