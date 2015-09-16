<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class CustomerRelation extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'customersrelations';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['relationtype_id','created_at','updated_at','active', 'customers_id', 'customers1_id','customers2_id','bankaccount_id','bankaccount1_id','bankaccount2_id','bankaccount3_id' ];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];

}
