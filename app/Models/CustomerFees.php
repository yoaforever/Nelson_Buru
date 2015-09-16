<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class CustomerFees extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'customer_fees';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['id','customers_id','fee_type','amount', 'percentage', 'created_date'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];
 	public $timestamps = false;

}
