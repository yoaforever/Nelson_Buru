<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class TransactionHistory extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'transaction_history';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['transactions_id','field','old_value', 'new_value', 'created_at','updated_at','users_id','transactions_status_id' ];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];
        
    //public $timestamps = false;
        
    /*     protected function getDateFormat()
    {
        return 'U';
    }*/

}
