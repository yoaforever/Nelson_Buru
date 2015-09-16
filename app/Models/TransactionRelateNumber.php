<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class TransactionRelateNumber extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'transactionsrelatednumbers';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['transactions_id', 'number', 'container','amount','created_at', 'updated_at','active','users_id'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];

}
