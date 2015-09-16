<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class TransactionComment extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'transactionscomments';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['transactions_id','customers_id','comment', 'created_at', 'updated_at','active','users_id' ];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];
        
        public $timestamps = false;
        
    /*     protected function getDateFormat()
    {
        return 'U';
    }*/

}
