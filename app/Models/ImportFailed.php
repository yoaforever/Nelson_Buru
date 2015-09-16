<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class ImportFailed extends Model  {

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'import_reports';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['company_name','import_date','file_name','status','reason'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];
        
    public $timestamps = false;
}
