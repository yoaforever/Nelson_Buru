<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class Report extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'report';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['payor_name','payor_number','type_txn', 'txn_number', 'category','creatory','type_payment','amount_debit','amount_credit','payee_name','payee_number','type_pay','created_at','updated_at' ];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];
        
       // public $timestamps = false;
        
    /*     protected function getDateFormat()
    {
        return 'U';
    }*/

}
