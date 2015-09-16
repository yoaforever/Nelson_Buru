<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;


class TransactionAttachment extends Model  {



	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'transaction_attachments';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['transaction_id','user_id','file_path', 'description', 'attachment_type','viewable_by_other_party','created','modified','active','file_name','file_extension' ];

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
