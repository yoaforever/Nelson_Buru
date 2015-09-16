<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class BankAccount extends Model  {

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'bankaccounts';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['number','name','routing_number','active','customers_id','bank_id','type','bank_name' ];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $dates = ['created_at', 'updated_at'];

	const TYPE_DEBIT = 1;
	const TYPE_CREDIT = 2;
}
