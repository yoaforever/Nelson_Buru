<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class TransactionDisputeDetail extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'transactions_disputedetails';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['transactions_id','dispute_reasons_id','dispute_categorys_id', 'description', 'created_at','updated_at','active','users_id' ];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];
        
    public $timestamps = false;
        
    

}
