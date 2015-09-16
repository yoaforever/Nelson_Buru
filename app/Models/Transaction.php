<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class Transaction extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'transactions';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['biz_area_id','recordtype','number', 'relatednumber', 'receiver','creator','transactions_types_id','departure_date','arrival_date','due_date','currency_id','amount','description','transactions_status_id','payorrefnumber','biller_id','payor_id','users_id','created_at','updated_at','active','disputed_amount','disputedrefnumber' ];

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
