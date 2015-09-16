<?php namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class UserActivationToken extends Model {

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'user_activation_tokens';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['user_id', 'token'];

	protected $dates = ['created_at', 'updated_at'];

	public function user() { return $this->belongsTo('App\Models\User', 'user_id'); }

	public function isExpired(){

		return Carbon::now()->gte($this->created_at->addDay());
	}
}
