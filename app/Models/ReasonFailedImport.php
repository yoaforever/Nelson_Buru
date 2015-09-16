<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class ReasonFailedImport extends Model  {


	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'reason_failed_import';


	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
        protected $fillable = ['description', 'created_at', 'updated_at'];
//
//	public function system_functions() { return $this->belongsToMany('App\Models\SystemFunction', 'role_granted_functions')->withTimestamps(); }
}
