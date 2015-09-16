<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class Branch extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'branches';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['users_id','branch_name','first_name','last_name'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];
 	//public $timestamps = false;

}
