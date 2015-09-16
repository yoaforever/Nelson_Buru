<?php namespace App\Models;

use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Model;
use App\User;
use App\Models\Role;

class SystemFunction extends Model  {


	use SoftDeletes;

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'system_functions';

    const ViewAirTransactions = 1;
    const ViewBizToBizTransactions = 2;
    const ViewRailTransactions = 3;
    const ViewTruckingTransactions = 4;
    const AddAttachments = 5;
    const EditAttachments = 6;
    const DisputeTransactions = 7;
    const ReplyDispute = 8;
    const VerifyTransactions = 9;    
    const ApproveTransactions = 10;    
    const CreateTransactions = 11;
    const EditTransactions = 12;
    const UploadTransactions = 13;
    const CancelTransactions = 14;
    const ResetCancelledTransactions = 15;
    const CreateFreightCorrections = 16;
    const EditFreightCorrections = 17;
    const UpdateProfile = 18;    
    const ManageNotifications = 19;
    const ViewReports = 20;        
    const ScheduleReports = 21;
    const ChangeUserRole = 22;
    const ChangeUserIndividualPermissions = 23;
    const ViewUserNotfications = 24;
    const ManageBranches = 25;
    const RequestLinkToBiller = 26;
    const ApplyForPayAnyBizCredit = 27;
    const CreateBillerLink = 28;
    const EditBillerLink = 29;
    const UpdateBillerLink = 30;    
    const CreatePayorLink = 31;
    const EditPayorLink = 32;
    const UpdatePayorLink = 33;
    const CreateUsers = 34;
    const EditUsers = 35;
    
	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['function_name'];

	protected $dates = ['created_at', 'updated_at', 'deleted_at'];

	public function roles() { return $this->belongsToMany('App\Models\Role', 'role_granted_functions')->withTimestamps(); }	

	public function users() { return $this->belongsToMany('App\User', 'user_granted_functions')->withTimestamps(); }		
}
