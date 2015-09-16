<?php 

use Illuminate\Database\Seeder;
use App\Models\SystemFunction;

class SystemFunctionSeeder extends Seeder {
 
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('system_functions')->delete();
 
        SystemFunction::create(['function_name' => 'View Air Transactions']);
        SystemFunction::create(['function_name' => 'View Biz to Biz Transactions']);        
        SystemFunction::create(['function_name' => 'View Rail Transactions']);
        SystemFunction::create(['function_name' => 'View Trucking Transactions']);
        SystemFunction::create(['function_name' => 'Add Attachments']);        
        SystemFunction::create(['function_name' => 'Edit Attachments']);
        SystemFunction::create(['function_name' => 'Dispute Transactions']);
        SystemFunction::create(['function_name' => 'Reply Dispute']);        
        SystemFunction::create(['function_name' => 'Verify Transactions']);
        SystemFunction::create(['function_name' => 'Approve Transactions']);
        SystemFunction::create(['function_name' => 'Create Transactions']);        
        SystemFunction::create(['function_name' => 'Edit Transactions']);
        SystemFunction::create(['function_name' => 'Upload Transactions']);
        SystemFunction::create(['function_name' => 'Cancel Transactions']);        
        SystemFunction::create(['function_name' => 'Reset Cancelled Transactions']);        
        SystemFunction::create(['function_name' => 'Create Freight Corrections']);
        SystemFunction::create(['function_name' => 'Edit Freight Corrections']);        
        SystemFunction::create(['function_name' => 'Update Profile']);
        SystemFunction::create(['function_name' => 'Manage Notifications']);
        SystemFunction::create(['function_name' => 'View Reports']);        
        SystemFunction::create(['function_name' => 'Schedule Reports']);
        SystemFunction::create(['function_name' => 'Change User Role']);        
        SystemFunction::create(['function_name' => 'Change User Individual Permissions']);
        SystemFunction::create(['function_name' => 'View User Notfications']);        
        SystemFunction::create(['function_name' => 'Manage Branches']);
        SystemFunction::create(['function_name' => 'Request Link to Biller']);        
        SystemFunction::create(['function_name' => 'Apply for PayAnyBiz Credit']);
        SystemFunction::create(['function_name' => 'Create Biller Link']);        
        SystemFunction::create(['function_name' => 'Edit Biller Link']);
        SystemFunction::create(['function_name' => 'Update Biller Link']);        
        SystemFunction::create(['function_name' => 'Create Payor Link']);   
        SystemFunction::create(['function_name' => 'Edit Payor Link']);        
        SystemFunction::create(['function_name' => 'Update Payor Link']);        
        SystemFunction::create(['function_name' => 'Create Users']); 
        SystemFunction::create(['function_name' => 'Edit Users']);
    }
 
}