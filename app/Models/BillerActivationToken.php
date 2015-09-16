<?php namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class BillerActivationToken extends Model {

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'biller_activation_tokens';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['biller_id', 'token'];

	protected $dates = ['created_at', 'updated_at'];

	public function payor() { return $this->belongsTo('App\Customer', 'biller_id'); }

	public function isExpired(){

		return Carbon::now()->gte($this->created_at->addDay());
	}
}
