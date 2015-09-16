<?php

/*
  |--------------------------------------------------------------------------
  | Application Routes
  |--------------------------------------------------------------------------
  |
  | Here is where you can register all of the routes for an application.
  | It's a breeze. Simply tell Laravel the URIs it should respond to
  | and give it the controller to call when that URI is requested.
  |
 */

use App\Models\TransactionDisputeDetail;
use App\Models\Transaction;

ini_set('display_errors', 1);
error_reporting(1);

Route::get('/', function() {
    return view('index');
});


Route::group(array(
    'prefix' => '/api'
        ), function() {
    Route::get('login/auth', 'AuthController@Login');
	Route::get('keepalive', function() { return 'OK'; });
    Route::get('login/destroy', 'AuthController@Logout');
    Route::get('register', 'RegistrationController@register');
    Route::get('recovery', 'RegistrationController@passwordRecovery');
    Route::get('change_password_old/{id}', 'UserController@changePasswordAfterSixtyDays');
    Route::get('lock_user_attempts/{id}', 'UserController@lockUserAfterFourAttempts');
    Route::get('check_ip', 'UserController@checkIp');
    Route::post('verify', 'UserController@verifyIp');
    Route::get('search_data_user/{id}', 'UserController@searchDataUser');
});

Route::get('/PayAnyBiz/Activation/{token}', 'RegistrationController@activate');
Route::post('/PayAnyBiz/ResetPassword', 'RegistrationController@resetPassword');


Route::group(array(
    'prefix' => '/api',
    'middleware' => 'auth'
        ), function() {
// Route::resource('posts','PostController');
});

Route::get('home', 'HomeController@index');

Route::resource('paginates', 'PaginatesController');


//this form is with de inside angular(para cuando lo entre)

Route::group(array(
    'prefix' => 'api'
        ), function() {

    Route::resource('users', 'UserController');
    Route::get('users/get_details/{id}', 'UserController@getDetails');
	Route::get('newCSuser', 'UserController@newCSuser');
    Route::get('rol_by_user/{id}', 'UserController@rolByUser');
    Route::get('list_users_rol/{id}', 'UserController@listMyUsersRol');
	Route::post('users/lock_user/{id}', 'UserController@lock_status');
	Route::post('users/user_status/{id}', 'UserController@user_status');
    Route::resource('citys', 'CityController');
    Route::resource('biz_areass', 'BizAreaController');
    Route::resource('transactions_types', 'TransactionTypeController');
    Route::resource('customers', 'CustomerController');
    Route::resource('countrys', 'CountryController');
    Route::resource('states', 'StateController');
    Route::resource('transactions', 'TransactionController');
	Route::get('autoSaveBiller', 'TransactionController@autoSaveBiller');
    Route::resource('transaction_budget', 'TransactionBudgetController');
    Route::get('transaction_budget/delete/{id}', 'TransactionBudgetController@destroy');
    Route::resource('trx_comments', 'TransactionCommentsController');
//For Add/update/fetch PAB Tasks
    Route::resource('tasks', 'TaskController');
    Route::put('tasks/update/{id}', 'TaskController@update');
    Route::get('tasks/destroy/{id}', 'TaskController@destroy');
    Route::get('mark_all', 'TaskController@mark_all');
    Route::get('active_tasks', 'TaskController@active_tasks');
    Route::get('mark_all', 'TaskController@mark_all');
    Route::post('search', 'CompanyController@search_company');
//for Mail
    Route::post('attachments', 'AttachmentController@attachments');
    Route::post('sendmail', 'MailBoxController@send_mail');
    Route::post('replay', 'MailBoxController@replay');
    Route::get('inbox', 'MailBoxController@inbox');
    Route::get('sentitems', 'MailBoxController@sentitems');
    Route::get('drafts', 'MailBoxController@drafts');
    Route::get('trash', 'MailBoxController@trash');
    Route::post('webmail_login', 'MailBoxController@webmail_login');
    Route::get('downloadAttachment/{msgNo}/{msgId}/{attachmentId}', 'MailBoxController@downloadAttachment');
    Route::get('delete_mail/{id}/{folder}', 'MailBoxController@delete_mail');
    Route::get('inboxCount', 'MailBoxController@inboxCount');
    Route::get('draftsCount', 'MailBoxController@draftsCount');
    Route::get('mail_details/{id}/{msgno}/{folder}', 'MailBoxController@mail_details');
    Route::get('active_tasks', 'TaskController@active_tasks');
    Route::get('trx_comments/fetch/{id}', 'TransactionCommentsController@getComments');
    Route::get('transaction_biller', 'TransactionController@searchTxtBiller');
    Route::get('count_all_transactions/{id}', 'TransactionController@countAllBillerTxt');
    Route::get('count_pending_transaction/{id}', 'TransactionController@countPendingBillerTxt');
    Route::get('count_verified_transaction/{id}', 'TransactionController@countVerifiedBillerTxt');
    Route::get('count_approved_transaction/{id}', 'TransactionController@countApprovedBillerTxt');
    Route::get('count_disputed_transaction/{id}', 'TransactionController@countDisputedBillerTxt');
    Route::resource('report', 'ReportController');
    Route::get('transaction_payor', 'TransactionController@searchTxtPayor');
    Route::get('count_all_payor_transactions/{id}', 'TransactionController@countAllPayorTxt');
    Route::get('count_pending_transaction_transaction/{id}', 'TransactionController@countPendingPayorTxt');
    Route::get('count_verified_payor_transaction/{id}', 'TransactionController@countVerifiedPayorTxt');
    Route::get('count_approved_payor_transaction/{id}', 'TransactionController@countApprovedPayorTxt');
    Route::get('count_disputed_payor_transaction/{id}', 'TransactionController@countDisputedPayorTxt');
    Route::get('transaction_customer', 'TransactionController@searchTxtCustomer');
});

Route::group(array(
    'prefix' => 'api'
        ), function() {
    Route::resource('transaction_status', 'TransactionStatusController');
    Route::put('transaction_status/verify/{id}', 'TransactionStatusController@verify');
    Route::put('transaction_status/pause/{id}', 'TransactionStatusController@pause');
    Route::put('transaction_status/reapprove/{id}', 'TransactionStatusController@reapprove');
    Route::put('transaction_status/cancel/{id}', 'TransactionStatusController@cancel');
	Route::get('mailCancelTransaction/{id}/{user_id}/{status}', 'TransactionStatusController@mailCancelTransaction');
	Route::get('mailApproveTransaction/{id}', 'TransactionStatusController@mailApproveTransaction');
	
	//Added by Iblesoft
    Route::put('transaction_status/approve_with_dispute/{id}', 'TransactionStatusController@approve_with_dispute');
    Route::resource('trxexports', 'TrxExports');
    Route::put('company_profile/{id}', 'CompanyController@update');
    Route::resource('payor', 'PayorController');
    Route::resource('biller', 'BillerController');
    Route::resource('permissions', 'PermissionController');
    Route::get('permission_role/{id}', 'PermissionController@searchPermissoRole');
    Route::resource('roles', 'RoleController');
    Route::get('payor_relation/{id}', 'PayorController@searchCustomerRelation');
    Route::get('biller_relation/{id}', 'BillerController@searchCustomerRelation');
    Route::get('biller_all_relation/{id}', 'BillerController@searchAllCustomerRelation');
    Route::resource('dispute_reason', 'DisputeReasonController');
    Route::resource('dispute_category', 'DisputeCategoryController');
    Route::resource('transaction_dispute', 'TransactionDisputeController');
    Route::get('transactions/print_transactions_details/{id}', 'TransactionController@print_transactions_details');
    Route::get('transactions/print_transactions_details_payor/{id}', 'TransactionController@print_transactions_details_payor');
    Route::get('transactions/print_all/biller/{id}', 'TransactionController@print_all_biller');
    Route::get('transactions/print_all/payor/{id}', 'TransactionController@print_all_payor');
	Route::post('transactions/neededtransactions', 'TransactionController@print_req_transactions');
    Route::get('transaction_history/{id}', 'TransactionController@get_history');
    Route::get('transaction_history/dispute/{id}', 'TransactionController@dispute_history');
	Route::post('company_fees', 'CompanyController@company_fees');
	Route::get('company_fees/{id}', 'CompanyController@fees_list');
	Route::post('set_customer_fee/{id}', 'CompanyController@set_customer_fee');
	//@khadar
    Route::get('transaction_dispute/details/{id}', 'TransactionDisputeController@disputeDetails');
    Route::get('dispute/reasons', 'DisputeController@reasons');
    Route::get('dispute/categories', 'DisputeController@categories');
    Route::post('dispute/update/{id}', 'DisputeController@update');
    Route::get('dispute_history/{id}', 'DisputeController@dispute_history');
	//For Branch fuctionality
	Route::resource('branches', 'BranchesController');
	Route::get('newBranch', 'BranchesController@new_branch');
	Route::get('branches/create', 'BranchesController@create');
	Route::get('branchconnect/{userid}/{custid}', 'BranchesController@activation');
	

    /* Rajendra - for chat */
    Route::put('company_users/{id}', 'ChatController@companyUsers');
    Route::post('chataction/{action}', 'ChatController@chatAction');
    Route::put('chatcompanies/{id}', 'ChatController@chatCompanies');
    Route::put('chatcompanyusers', 'ChatController@chatCompanyUsers');
	Route::post('set_visibility', 'ChatController@set_chat_status');
	Route::get('chatstatus/{id}', 'ChatController@get_chat_status');
	Route::post('chat_messages/{id}', 'ChatController@update_msg_status');
    /* Rajendra - for BankInfo */
    Route::get('customerbankinfo/{id}', 'CustomerController@getBankInfo');
    Route::put('updatecustomerbankinfo/{id}', 'CustomerController@updateCustomerBankInfo');
    Route::get('sftp', 'ImportController@getcronsftp');
});

Route::group(array(
    'prefix' => 'api'
        ), function() {
    Route::get('payor_list_first_selected/{id}', 'PayorController@listSortedPayor');
	
	Route::get('all_billers', 'BillerController@allCustomerRelation');
    Route::get('biller_list_first_selected/{id}', 'BillerController@listSortedBiller');
    Route::get('biller_relation_active/{id}', 'BillerController@searchCustomerRelationActive');
    Route::get('search_biller_exist', 'BillerController@searchExistBiller');
    Route::get('connect_biller', 'BillerController@connectBillerExist');
    Route::get('search_biller_connected/{id}', 'BillerController@searchBillersConnected');
    Route::get('search_biller_not_connected/{id}', 'BillerController@searchBillersNotConnected');
    Route::post('update_user_profile/{id}', 'UserController@updateProfile');
    Route::get('count_customers', 'CustomerController@countCustomers');
    Route::get('count_users', 'UserController@countUsers');
    Route::get('count_billers', 'CustomerRelationController@countBillers');
    Route::get('count_payors', 'CustomerRelationController@countPayors');
    Route::get('count_pending', 'TransactionController@countAllPending');
    Route::get('count_verified', 'TransactionController@countAllVerified');
    Route::get('count_approved', 'TransactionController@countAllApproved');
    Route::get('count_disputed', 'TransactionController@countAllDisputed');
    Route::get('count_paused', 'TransactionController@countAllPaused');
    Route::get('count_canceled', 'TransactionController@countAllCanceled');
    Route::get('report/failed_import_report', 'ReportController@getFailedImportReport');
});

Route::group(array(
    'prefix' => 'api'
        ), function() {
    Route::get('user_by_company/{id}', 'UserController@listUsersByCompany');
	Route::get('user_by_role/{id}', 'UserController@listUsersByRole');
});



Route::post('trximport', 'ImportController@transimport');
Route::resource('payormport', 'ImportController@payorimport');
Route::resource('billerimport', 'ImportController@billerimport');
Route::resource('userimport', 'ImportController@userimport');

//Route::get('transactions/joinTab/{id}', 'TransactionController@joinTab');


Route::get('/PayAnyBiz/ActivationPayor/{token}', 'PayorController@activatePayor');
Route::post('/PayAnyBiz/ActivationP/{id}', 'PayorController@update');
Route::get('/PayAnyBiz/ConnectPayor/{id}', 'PayorController@updateConnectPayor');
Route::get('/PayAnyBiz/Activation/{token}', 'PayorController@activateUser');

//
Route::get('/PayAnyBiz/ActivationBiller/{token}', 'BillerController@activateBiller');
Route::post('/PayAnyBiz/ActivationB/{id}', 'BillerController@update');
Route::get('/PayAnyBiz/ConnectBiller/{id}', 'BillerController@updateConnectBiller');
Route::get('/PayAnyBiz/Activation/{token}', 'BillerController@activateUser');

Route::get('/cities', function() {
    return view('cities_by_state.cities');
});
Route::get('/states', function() {
    return view('cities_by_state.states');
});

Route::get('/cities_state', function() {
    return view('cities_by_state.cities_state');
});

Route::resource('uploading', 'AttachmentController@uploading');
Route::get('getattachments/{id}', 'AttachmentController@getAttachments');
Route::put('attachment/email/{id}', 'AttachmentController@send_email');
Route::resource('deleteAttachment', 'AttachmentController@deleteAttachment');
Route::resource('downloadattachment', 'AttachmentController@downloadAttachment');
Route::resource('nacha', 'NachafilesController');
Route::get('download', 'NachafilesController@download');
Route::post('saveFtp', 'FtpController@saveFtp');
Route::get('getFtp/{id}', 'FtpController@getFtp');

/*
 * @author : IBlesoft
 * @Batch file Creatation
 * @Uploading batch file to destination server.
 */
Route::get('batchcreation', function() {

    set_include_path(get_include_path() . PATH_SEPARATOR . app_path() . '/libraries');

    require(app_path() . '/libraries/Net/SFTP.php');

    $db = new DB;

    $batch = date('ymd', strtotime('-1 days'));
    $batchid = $batch . '-1';

    $trxexports = DB::table('trx_exports')->leftJoin('citys', 'citys.id', '=', 'trx_exports.Payor_city')->leftJoin('states', 'states.id', '=', 'trx_exports.Payor_state')->leftJoin('customers', 'customers.id', '=', 'trx_exports.Payee_is_PAB')->select('trx_exports.*', 'citys.name as payor_city_name', 'states.name as payor_state_name', 'customers.legal_name as Payee')->where('export_batch_id', $batchid)->get();

    if (empty($trxexports)) {
        echo "<h3>There is no transactions verified on " . date('Y-m-d', strtotime("-1 days")) . '<h3>';
        exit;
    }

    $date = date("Ymd", strtotime("-1 days"));

    $hours = date('H');

    $minutes = date('m');

    $seconds = date('i');

    if (!is_dir('uploads/nachafiles/' . date('Y-m-d', strtotime("-1 days")))) {
        if (!mkdir('uploads/nachafiles/' . date('Y-m-d', strtotime("-1 days")), 0777)) {
            echo "<h3>Error while creating directory Please contact administrator</h3>";
            exit;
        }
    }

    //$filename = $date . $hours . $minutes . $seconds . '.csv';

    $batch_id = $trxexports[0]->export_batch_id;

    $filename = $batch_id . '-' . $date . $hours . $minutes . $seconds . '.csv';

    $filename = "uploads/nachafiles/" . date('Y-m-d', strtotime("-1 days")) . '/' . $filename;

    $handle = fopen($filename, 'w+');

    chmod($filename, 0777);
    /*
     * @ Defining CSV file Headers.
     * */
    fputcsv($handle, array(
        'CompanyName/ContactName',
        'Address',
        'Address2',
        'City',
        'State',
        'PostalCode',
        'Phone',
        'EMail',
        'Payee',
        'Date',
        'CheckNumber',
        'Amount',
        'RoutingNumber',
        'AccountNumber',
        'batch_id',
        'Notes',
        'Memo'
    ));
    /*
     * @ Writing transactions data into CSV file.
     * */
    foreach ($trxexports as $row) {

        fputcsv($handle, array(
            $row->Payor_Name,
            $row->Payor_Address,
            '',
            $row->payor_city_name,
            $row->payor_state_name,
            $row->Payor_Zip,
            $row->Payor_Phone,
            $row->Payor_Email,
            $row->Payee,
            date('m/d/Y', strtotime($row->created_at)),
            '',
            $row->Trx_Amount,
            $row->Payor_Routing_Num,
            $row->Payor_Account_Num,
            $row->export_batch_id,
            '',
            ''
        ));
    }
    fclose($handle);


    //Saving the file in location directory path for future refrence.
    $local_directory = 'uploads/nachafiles/' . date('Y-m-d', strtotime("-1 days")) . '/';

    //Destination root path
    $remote_directory = '/';

    //Connecting to Destination server.
    $sftp = new Net_SFTP('50.16.196.174');
    //Checking authentication.
    if (!$sftp->login('payanybiz', 'welcome9mw48')) {
        exit('Login Failed');
    }
    //Reading files from location directory to upload destination server.
    $files_to_upload = array();

    if ($handle = opendir($local_directory)) {
        /* This is the correct way to loop over the directory. */
        while (false !== ($file = readdir($handle))) {
            if ($file != "." && $file != "..") {
                $files_to_upload[] = $file;
            }
        }
        closedir($handle);
    }
    //uploading a file to destination server.
    if (!empty($files_to_upload)) {
        $up_filename = explode('/', $filename);

        if (in_array($up_filename[3], $files_to_upload)) {
            /* Upload the local file to the remote server put('remote file', 'local file'); */

            $success = $sftp->put($remote_directory . $up_filename[3], $local_directory . $up_filename[3], NET_SFTP_LOCAL_FILE);
            if ($success) {
                echo "<h3>File uploaded Successfully.<br><br> FileName: " . $up_filename[3] . "</h3>";
                exit(0);
            }
        } else {
            echo "Erroor While uploading file.";
        }
    }
});

Route::get('feescript', function() {

    set_include_path(get_include_path() . PATH_SEPARATOR . app_path() . '/libraries');

    require(app_path() . '/libraries/Net/SFTP.php');

    $db = new DB;

    $batch2 = date('ymd', strtotime('-1 days'));
    $batchid2 = $batch2 . '-2';

    $trxexports = DB::table('trx_exports')->leftJoin('citys', 'citys.id', '=', 'trx_exports.Payor_city')->leftJoin('states', 'states.id', '=', 'trx_exports.Payor_state')->leftJoin('customers', 'customers.id', '=', 'trx_exports.Payee_is_PAB')->select('trx_exports.*', 'citys.name as payor_city_name', 'states.name as payor_state_name', 'customers.legal_name as Payee')->where('export_batch_id', $batchid2)->get();


    if (empty($trxexports)) {
        echo "<h3>There is no transactions verified on " . date('Y-m-d', strtotime("-1 days")) . '<h3>';
        exit;
    }

    $date = date("Ymd", strtotime("-1 days"));

    $hours = date('H');

    $minutes = date('m');

    $seconds = date('i');

    if (!is_dir('uploads/nachafiles/' . date('Y-m-d', strtotime("-1 days")))) {
        if (!mkdir('uploads/nachafiles/' . date('Y-m-d', strtotime("-1 days")), 0777)) {
            echo "<h3>Error while creating directory Please contact administrator</h3>";
            exit;
        }
    }

    //$filename = $date . $hours . $minutes . $seconds . '.csv';

    $batch_id = $trxexports[0]->export_batch_id;

    $filename = $batch_id . '-' . $date . $hours . $minutes . $seconds . '.csv';

    $filename = "uploads/nachafiles/" . date('Y-m-d', strtotime("-1 days")) . '/' . $filename;

    $handle = fopen($filename, 'w+');

    chmod($filename, 0777);
    /*
     * @ Defining CSV file Headers.
     * */
    fputcsv($handle, array(
        'CompanyName/ContactName',
        'Address',
        'Address2',
        'City',
        'State',
        'PostalCode',
        'Phone',
        'EMail',
        'Payee',
        'Date',
        'CheckNumber',
        'Amount',
        'RoutingNumber',
        'AccountNumber',
        'batch_id',
        'Notes',
        'Memo'
    ));
    /*
     * @ Writing transactions data into CSV file.
     * */
    foreach ($trxexports as $row) {
        fputcsv($handle, array(
            $row->Payor_Name,
            $row->Payor_Address,
            '',
            $row->payor_city_name,
            $row->payor_state_name,
            $row->Payor_Zip,
            $row->Payor_Phone,
            $row->Payor_Email,
            $row->Payee,
            date('m/d/Y', strtotime($row->created_at)),
            '',
            $row->Trx_Amount,
            $row->Payor_Routing_Num,
            $row->Payor_Account_Num,
            $row->export_batch_id,
            '',
            ''
        ));
    }
    fclose($handle);


    //Saving the file in location directory path for future refrence.
    $local_directory = 'uploads/nachafiles/' . date('Y-m-d', strtotime("-1 days")) . '/';

    //Destination root path
    $remote_directory = '/';

    //Connecting to Destination server.
    $sftp = new Net_SFTP('50.16.196.174');
    //Checking authentication.
    if (!$sftp->login('payanybiz', 'welcome9mw48')) {
        exit('Login Failed');
    }
    //Reading files from location directory to upload destination server.
    $files_to_upload = array();

    if ($handle = opendir($local_directory)) {
        /* This is the correct way to loop over the directory. */
        while (false !== ($file = readdir($handle))) {
            if ($file != "." && $file != "..") {
                $files_to_upload[] = $file;
            }
        }
        closedir($handle);
    }
    //uploading a file to destination server.
    if (!empty($files_to_upload)) {
        $up_filename = explode('/', $filename);

        if (in_array($up_filename[3], $files_to_upload)) {
            /* Upload the local file to the remote server put('remote file', 'local file'); */
            $success = $sftp->put($remote_directory . $up_filename[3], $local_directory . $up_filename[3], NET_SFTP_LOCAL_FILE);
            if ($success) {
                echo "<h3>File uploaded Successfully.<br><br> FileName: " . $up_filename[3] . "</h3>";
                exit(0);
            }
        } else {
            echo "Erroor While uploading file.";
            exit(0);
        }
    }
});


Route::post('ftpSettings', function() {
    set_include_path(get_include_path() . PATH_SEPARATOR . app_path() . '/libraries');
    require(app_path() . '/libraries/Net/SFTP.php');
    $host = Input::get('ftp_host');
    $username = Input::get('ftp_user');
    $password = Input::get('ftp_pass');
    $import_type = Input::get('importType');
    $user_id = Input::get('user_id');
    try {
        $sftp = new Net_SFTP($host);
        //Checking authentication.
        if (!$sftp->login($username, $password)) {
            return Response::json(['error' => true, 'msg' => 'Invalid Credentails.'], 200);
        }
        if (!empty($_FILES['myFile'])) {

            switch ($import_type) {
                case 1:
                    if (!$sftp->is_dir('users')) {
                        $sftp->mkdir('users');
                    }
                    if (!$sftp->is_dir('users/users_' . $user_id)) {
                        $sftp->mkdir('users/users_' . $user_id);
                    }
                    break;
                case 2:
                    if (!$sftp->is_dir('payors')) {
                        $sftp->mkdir('payors');
                    }
                    if (!$sftp->is_dir('payors/payors_' . $user_id)) {
                        $sftp->mkdir('payors/payors_' . $user_id);
                    }
                    break;
                case 3:
                    if (!$sftp->is_dir('billers')) {
                        $sftp->mkdir('billers');
                    }
                    if (!$sftp->is_dir('billers/billers_' . $user_id)) {
                        $sftp->mkdir('billers/billers_' . $user_id);
                    }
                    break;
                case 4:
                    if (!$sftp->is_dir('transactions')) {
                        $sftp->mkdir('transactions');
                    }
                    if (!$sftp->is_dir('transactions/transactions_' . $user_id)) {
                        $sftp->mkdir('transactions/transactions_' . $user_id);
                    }
                    break;
                default:
                    break;
            }
            foreach ($_FILES['myFile']['tmp_name'] as $key => $tmp_name) {
                $file_name = $_FILES['myFile']['name'][$key];
                $file_size = $_FILES['myFile']['size'][$key];
                $file_tmp = $_FILES['myFile']['tmp_name'][$key];
                $file_type = $_FILES['myFile']['type'][$key];
                switch ($import_type) {
                    case 1:
                        $sftp->put('users/users_' . $user_id . '/' . $file_name, $file_tmp, NET_SFTP_LOCAL_FILE);
                        break;
                    case 2:
                        $sftp->put('payors/payors_' . $user_id . '/' . $file_name, $file_tmp, NET_SFTP_LOCAL_FILE);
                        break;
                    case 3:
                        $sftp->put('billers/billers_' . $user_id . '/' . $file_name, $file_tmp, NET_SFTP_LOCAL_FILE);
                        break;
                    case 4:
                        $sftp->put('transactions/transactions_' . $user_id . '/' . $file_name, $file_tmp, NET_SFTP_LOCAL_FILE);
                        break;
                    default:
                        break;
                }
            }
            return Response::json(['success' => true, 'msg' => 'Files uploaded Successfully'], 200);
        }
        return Response::json(['success' => true, 'msg' => 'Connected Successfully'], 200);
    } catch (Exception $e) {
        return Response::json(['error' => true, 'msg' => 'Invalid Credentails.'], 200);
    }
});







