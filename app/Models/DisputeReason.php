<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class DisputeReason extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'dispute_reasons';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['description', 'created_at', 'updated_at','active'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];

}
