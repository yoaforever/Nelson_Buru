<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class CityTimeZone extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'citytimezones';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['name', 'hours_diff', 'created_at', 'updated_at','active', 'country_id'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];

}
