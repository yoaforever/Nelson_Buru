<?php namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use Log;
use DB;
use Net_SFTP;
use Mail;
use Illuminate\Http\Response;

class Ftp extends Model  {

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'ftp_settings';

	/**
	 * The attributes that are mass assignable.
	 *
	 * @var array
	 */
	protected $fillable = ['user_id','customer_id','ftp_host','ftp_username','ftp_password','cron_time','created_at'];

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = [];
        
    public $timestamps = false;
    
    public function cronSchedule()
    {
      ini_set('memory_limit', '2048M');
      ini_set('max_execution_time', 300);
	  set_include_path(get_include_path() . PATH_SEPARATOR . app_path() . '/libraries');
    //require('Net/SFTP.php');
    //echo app_path() . '/libraries/Net/SFTP.php';exit;
	//$ftp = new Ftp();
	$ftpsList =  $this->get();
	//Log::info($ftpsList);
	if(!empty($ftpsList)) : foreach($ftpsList as $ftpDetails) : 
		$host = $ftpDetails->ftp_host;
		$username = $ftpDetails->ftp_username;
		$password = $ftpDetails->ftp_password;
		try{
			$sftp = new Net_SFTP($host);
		    if (!$sftp->login($username, $password)) {
		        Log::info('Invalid Credentails.');
		        //return Response::json(['error' => true,'msg' => 'Invalid Credentails.'], 200);
		    }
		    
		  echo date('G:i');
		  if($ftpDetails->cron_time == date('G:i'))
		  {
			$customer = new Customer();
			$customerDetails = Customer::where('id', '=', $ftpDetails->customer_id)->first();
			
			if($sftp->is_dir('billers/billers_'.$ftpDetails->user_id)) {
				$files = $sftp->nlist('billers/billers_'.$ftpDetails->user_id);
				$importFailure = 0;
				
				foreach($files as $file) { 
					if($file != '.' && $file != '..') {
						$filename = $file;
						$sftp->chmod(07777,$filename);
						$ext = pathinfo($filename, PATHINFO_EXTENSION);
						if( $ext !== 'csv') {
							continue;
						}
						$fileData = $sftp->get('billers/billers_'.$ftpDetails->user_id . '/' . $filename, 'uploads/' . $filename);
						$path = public_path() . '/uploads/'.$filename;
						$file_handle = fopen($path, 'r');
						
						$line_of_text = array();
						while (!feof($file_handle)) {
				            $line_of_text[] = fgetcsv($file_handle, 2048);
				        }
				        fclose($file_handle);
				        
						$Billers = $line_of_text;
						$count = 0;
						foreach ($Billers as $Biller) {
			                if ($count > 0 && count($Biller) == 18) {
								try {
									$newbiller = array_filter($Biller); //which will removes columns with empty values
									if (!empty($newbiller)) {//if atleast one column has value
										if (empty($Biller[0]) ||
											empty($Biller[1]) || 
											empty($Biller[2]) || 
											empty($Biller[3]) || 
											empty($Biller[6]) || 
											empty($Biller[7]) || 
											empty($Biller[8]) || 
											empty($Biller[9]) || 
											empty($Biller[10])) {
											Log::info('Required fields (Company_Name,Email_Address,Phone_Number,TIN,Address,City,Zip_Code,State,Country) are missing..');
											//return Response::json(['success' => true,'msg' => 'Required fields (Company_Name,Email_Address,Phone_Number,TIN,Address,City,Zip_Code,State,Country) are missing.'], 200);
											return true;
										}
										$existsbiller = Customer::where('legal_name', '=', $Biller[0])->where('email', '=', $Biller[1], 'OR')->first();
										if (sizeof($existsbiller) > 0) {//if Biller already exists
										  //Log::info('existing customer');
											if ($existsbiller->phone == $Biller[2] && $existsbiller->tin == $Biller[3] && $existsbiller->dba == $Biller[4] && $existsbiller->fax == $Biller[5] && $existsbiller->address == $Biller[6] && $existsbiller->city_id == $Biller[7] &&$existsbiller->zip_postal == $Biller[8] && $existsbiller->state_id == $Biller[9] && $existsbiller->country_id == $Biller[10]) {
												
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 0;
												$importFailed->reason = "Data Duplicated in Row:$count";
												$importFailed->save();
												$importFailure = 1;
												continue;
											} else {
												$existsbiller->phone 		= $Biller[2];
												$existsbiller->tin 			= $Biller[3];
												$existsbiller->dba 			= $Biller[4];
												$existsbiller->fax 			= $Biller[5];
												$existsbiller->address 		= $Biller[6];
												$existsbiller->city_id 		= $Biller[7];
												$existsbiller->zip_postal 	= $Biller[8];
												$existsbiller->state_id 	= $Biller[9];
												$existsbiller->country_id 	= $Biller[10];
												$existsbiller->save();
												
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 1;
												$importFailed->reason = "Row: $count:- Biller Updated Successfully";
												$importFailed->save();
											}
										} else {
										   //Log::info('new customer');
											$customer = new Customer();
											$payor_current = Customer::where('id', '=', $Biller[17]);
											if(!empty($payor_current)) {
												$customer->legal_name 		= $Biller[0];
												$customer->email 			= $Biller[1];
												$customer->phone 			= $Biller[2];
												$customer->tin 				= $Biller[3];
												$customer->dba 				= $Biller[4];
												$customer->fax 				= $Biller[5];
												$customer->address 			= $Biller[6];
												$customer->city_id 			= $Biller[7];
												$customer->zip_postal 		= $Biller[8];
												$customer->state_id 		= $Biller[9];
												$customer->country_id 		= $Biller[10];
												$customer->type_customer 	= 1;
												$customer->save();
											
												$new = new BankAccount;
												$new->number = $Biller[11];
												$new->routing_number = $Biller[12];
												$new->active = 0;
												$new->customers_id = $customer->id;
												$new->type = 1;
												$new->bank_name = $Biller[13];
												$new->save();
											
												$new_c = new BankAccount;
												$new_c->number = $Biller[14];
												$new_c->routing_number = $Biller[15];
												$new_c->active = 0;
												$new_c->customers_id = $customer->id;
												$new_c->type = 2;
												$new_c->bank_name = $Biller[16];
												$new_c->save();
											
												$customer_relation = new CustomerRelation;
												$customer_relation->customers_id = $customer->id;
												$customer_relation->customers1_id = $Biller[17];
												$customer_relation->active = 1;
												$customer_relation->save();
												
												$BillerId = $customer->id;
												
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 1;
												$importFailed->reason = "Row: $count:- Biller Created Successfully";
												$importFailed->save();
												
												/* @User Email - Generate token in biller_activation_token and send Invitation to Biller */
												$activation_token = new BillerActivationToken;
												$activation_token->biller_id = $BillerId;
												$activation_token->token = md5(uniqid(date('mdYhis'), true));
												$activation_token->save();
												$activation_url = url('/PayAnyBiz/ActivationBiller', ['token' => $activation_token->token]);
												$data = array('email' => $Biller[1], 'name' => $payor_current->legal_name);
												Mail::send('emails.billerInvite', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
													$message->to($data['email'], $data['name'])->subject('You have been invited to Join PayAnyBiz by ' . $data['name']);
												});
											}else {
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 0;
												$importFailed->reason = "Invalid Company ID in Row:$count";
												$importFailed->save();
												$importFailure = 1;
												continue;
											}
										}
									}
								}catch (Exception $e) {
									continue;
								}
			                }$count++;    
		                }
						if($importFailure == 1) {
							unlink($path);
						}
						if($importFailure == 0) {
							$sftp->delete('billers/billers_'.$ftpDetails->user_id .'/'.$filename);
							unlink($path);
						}
		            }
				}
			}
			if($sftp->is_dir('payors/payors_'.$ftpDetails->user_id)) {
				
				$files = $sftp->nlist('payors/payors_'.$ftpDetails->user_id);
				$importFailure = 0;
				foreach($files as $file) { 
					if($file != '.' && $file != '..') {
						
						$filename = $file;
						$sftp->chmod(07777,$filename);
						$ext = pathinfo($filename, PATHINFO_EXTENSION);
						if( $ext !== 'csv') {
							continue;
						}
						$fileData = $sftp->get('payors/payors_'.$ftpDetails->user_id .'/'.$filename, 'uploads/' . $filename);
						$path = public_path() . '/uploads/'.$filename;
						$file_handle = fopen($path, 'r');
				        $line_of_text = array();
						while (!feof($file_handle)) {
				            $line_of_text[] = fgetcsv($file_handle, 1024);
				        }
						
				        fclose($file_handle);
						$Payors = $line_of_text;
						$count = 0;	
						foreach ($Payors as $Payor) {
			                if ($count > 0 && count($Payor) == 7) {
								try {
									$newpayor = array_filter($Payor); //which will removes columns with empty values
									if (!empty($newpayor)) {//if atleast one column has value
										if (empty($Payor[0]) || empty($Payor[1]) || empty($Payor[2])) {
											
											Log::info('Required fields (legal_name,email,phone) are missing.');
											return true;
											//return Response::json(['success' => true,'msg' => 'Required fields (legal_name,email,phone) are missing.'], 200);
										}
										$existspayor = Customer::where('legal_name', '=', $Payor[0])
												->where('email', '=', $Payor[1], 'OR')
												->first();
										
										if (sizeof($existspayor) > 0) {//if Biller already exists
											if ($existspayor->phone == $Payor[2] &&
													$existspayor->tin == $Payor[3] &&
													$existspayor->dba == $Payor[4] &&
													$existspayor->fax == $Payor[5]
											) {
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 0;
												$importFailed->reason = "Data Duplicated in Row:$count";
												$importFailed->save();
												$importFailure = 1;
												continue;
											} else {
												$existspayor->phone = $Payor[2];
												$existspayor->tin = $Payor[3];
												$existspayor->dba = $Payor[4];
												$existspayor->fax = $Payor[5];

												$existspayor->save();
												
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 1;
												$importFailed->reason = "Row: $count:- Payor Updated Successfully";
												$importFailed->save();
												
												$data = array('email' => $Payor[1], 'name' => $Payor[0]);

												Mail::send('emails.payorInvite', array('name' => $data['name'], 'email' => $data['email']), function($message) use ($data) {
													$message->to($data['email'], $data['name'])->subject('You have been invited to Join PayAnyBiz by' . $data['name']);
												});
											}
										} else {//if Biller doesn't exists									
											$customer = new Customer();
											$payor_current = Customer::where('id', '=', $Payor[6]);
											if(!empty($payor_current)) {
												$customer->legal_name = $Payor[0];
												$customer->email = $Payor[1];
												$customer->phone = $Payor[2];
												$customer->tin = $Payor[3];
												$customer->dba = $Payor[4];
												$customer->fax = $Payor[5];
												$customer->type_customer = 0;

												$customer->save();
												
												$customer_relation = new CustomerRelation;
												$customer_relation->customers_id = $Payor[6];
												$customer_relation->customers1_id = $customer->id;
												$customer_relation->active = 1;
												$customer_relation->save();
											

												$PayorId = $customer->id;

												/* @User Email - Generate token in payor_activation_token and send invitation to payor */
												$activation_token = new PayorActivationToken;
												$activation_token->payor_id = $PayorId;
												$activation_token->token = md5(uniqid(date('mdYhis'), true));
												
												$activation_token->save();
												
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 1;
												$importFailed->reason = "Row: $count:- Payor Created Successfully";
												$importFailed->save();

												$activation_url = url('/PayAnyBiz/ActivationPayor', ['token' => $activation_token->token]);

												$data = array('email' => $Payor[1], 'name' => $payor_current->legal_name);

												Mail::send('emails.payorInvite', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
													$message->to($data['email'], $data['name'])->subject('You have been invited to Join PayAnyBiz by' . $data['name']);
												});
											}else {
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 0;
												$importFailed->reason = "Invalid Company ID in Row:$count";
												$importFailed->save();
												$importFailure = 1;
												continue;
											}
										}
									}
								}catch (Exception $e) {
									continue;
								}
			                }
			                $count = $count + 1;
			            }
						if($importFailure == 1) {
							unlink($path);
						}
						if($importFailure == 0) {
							$sftp->delete('payors/payors_'.$ftpDetails->user_id . '/' . $filename);
							unlink($path);
						}
					}
				}
			}
			if($sftp->is_dir('users/users_'.$ftpDetails->user_id)) {
				$files = $sftp->nlist('users/users_'.$ftpDetails->user_id);
				$importFailure = 0;
				foreach($files as $file) { 
					if($file != '.' && $file != '..') {
						$filename = $file;
						$sftp->chmod(07777,$filename);
						$ext = pathinfo($filename, PATHINFO_EXTENSION);
						if( $ext !== 'csv') {
							continue;
						}
						$fileData = $sftp->get('users/users_'.$ftpDetails->user_id . '/'.$filename, 'uploads/' . $filename);
						$path = public_path() . '/uploads/'.$filename;
						$file_handle = fopen($path, 'r');
				        $line_of_text = array();
						while (!feof($file_handle)) {
				            $line_of_text[] = fgetcsv($file_handle, 1024);
				        }
				        fclose($file_handle);
						$Users = $line_of_text;
						$count = 0;	
						foreach ($Users as $User) {
			                if ($count > 0 && count($User) == 6) {
								try {
									$newuser = array_filter($User);
									if (!empty($newuser)) {
										//check if users exists with the customer_id
										$isuserexists = User::where('username', '=', $User[1])->first();
										
										if (sizeof($isuserexists) > 0) { //if user already exists
											//check if all the data is duplicated
											if (
												$isuserexists->customers_id == $User[0] &&
												$isuserexists->email == $User[2] &&
												$isuserexists->lastname == $User[3] &&
												$isuserexists->name == $User[4] &&
												$isuserexists->role_id == $User[5]
											) {
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 0;
												$importFailed->reason = "Data Duplicated in Row:$count";
												$importFailed->save();
												continue;
											} else {
												//Update Existing user information
												$customer = new Customer();
												$Exists = Customer::where('id', '=', $User[0]);
												
												if(!empty($Exists)) {
													$isuserexists->customers_id = $User[0];
													$isuserexists->email = $User[2];
													$isuserexists->lastname = $User[3];
													$isuserexists->name = $User[4];
													$isuserexists->role_id = $User[5];
													$isuserexists->save();
													
													$importFailed = new ImportFailed;
													$importFailed->company_name = $customerDetails->legal_name;
													$importFailed->import_date = date('Y-m-d H:i:s');
													$importFailed->file_name = $filename;
													$importFailed->status = 1;
													$importFailed->reason = "Row: $count:- User Updated Successfully";
													$importFailed->save();
													
													$data = array('email' => $User[2], 'name' => $User[4]);
													Mail::send('emails.updatedUser', array('name' => $data['name'], 'email' => $data['email']), function($message) use ($data) {
														$message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
													});
												}else {
													$importFailed = new ImportFailed;
													$importFailed->company_name = $customerDetails->legal_name;
													$importFailed->import_date = date('Y-m-d H:i:s');
													$importFailed->file_name = $filename;
													$importFailed->status = 0;
													$importFailed->reason = "Invalid Customer ID in Row:$count";
													$importFailed->save();
													$importFailure = 1;
												}
											}
										} else {
											//if user doesn't exists
											//Create New User
											
											$customer = new Customer();
											$Exists = Customer::where('id', '=', $User[0])->first();
											if(!empty($Exists)) {
												$user = new User;
												$user->username = $User[1];
												$user->email = $User[2];
												$user->lastname = $User[3];
												$user->name = $User[4];
												$user->role_id = $User[5];
												$user->customers_id = $User[0];
												$user->save();
												$UserId = $user->id;
												
												/* @User Email - Generate token in user_activation_token and send it to user */
												$activation_token = new UserActivationToken;
												$activation_token->user_id = $UserId;
												$activation_token->token = md5(uniqid(date('mdYhis'), true));
												$activation_token->save();
												
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 1;
												$importFailed->reason = "Row: $count:- User Created Successfully";
												$importFailed->save();
												
												$activation_url = url('/PayAnyBiz/Activation', ['token' => $activation_token->token]);
												$data = array('email' => $User[2], 'name' => $User[4]);
												Mail::send('emails.activation', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
													$message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
												});
											}else {
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 0;
												$importFailed->reason = "Invalid Customer ID in Row:$count";
												$importFailed->save();
												$importFailure = 1;
											}
										}//if user doesn'texists
									}
								}catch (Exception $e) {
									continue;
								}
			                }
			                $count = $count + 1;
			            }
						if($importFailure == 1) {
							unlink($path);
						}
						if($importFailure == 0) {
							$sftp->delete('users/users_'.$ftpDetails->user_id . '/' . $filename);
							unlink($path);
						}
					}
				}
			}
			if($sftp->is_dir('transactions/transactions_'.$ftpDetails->user_id)) {
				$files = $sftp->nlist('transactions/transactions_'.$ftpDetails->user_id);
				$importFailure = 0;
				foreach($files as $file) { 
					if($file != '.' && $file != '..') {
						$filename = $file;
						$sftp->chmod(07777,$filename);
						$ext = pathinfo($filename, PATHINFO_EXTENSION);
						if( $ext !== 'csv') {
							continue;
						}
						
						$fileData = $sftp->get('transactions/transactions_' .$ftpDetails->user_id .'/'.$filename, 'uploads/' . $filename);
						$path = public_path() . '/uploads/'.$filename;
						$file_handle = fopen($path, 'r');
				        $line_of_text = array();
						while (!feof($file_handle)) {
				            $line_of_text[] = fgetcsv($file_handle, 1024);
				        }
				        fclose($file_handle);
						$Transactions = $line_of_text;
						$count = 0;
						foreach ($Transactions as $Trans) {
							if ($count > 0 && count($User) == 12) {		                    
								try {
									$newtrans = array_filter($Trans); //which will removes columns with empty values
									if (!empty($newtrans)) { //if atleast one column has value
										$existstx = Transaction::where('number', '=', $Trans[5])->first();
										if (sizeof($existstx) > 0) {//if Transaction already exists
											if ($existstx->amount == $Trans[0] &&
													$existstx->payor_id == $Trans[1] &&
													$existstx->biller_id == $Trans[2] &&
													$existstx->transactions_types_id == $Trans[3] &&
													$existstx->relatednumber == $Trans[6] &&
													$existstx->biz_area_id == $Trans[4] &&
													$existstx->due_date == date('Y-m-d h:i:s', strtotime($Trans[7])) &&
													$existstx->arrival_date == date('Y-m-d h:i:s', strtotime($Trans[8])) &&
													$existstx->departure_date == date('Y-m-d h:i:s', strtotime($Trans[9])) &&
													$existstx->payorrefnumber == $Trans[10] &&
													$existstx->transactions_status_id == $Trans[11]
											) {
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 0;
												$importFailed->reason = "Data Duplicated in Row:$count";
												$importFailed->save();
												$importFailure = 1;
												continue;
											} else {
												$existstx->amount = $Trans[0];
												$existstx->payor_id = $Trans[1];
												$existstx->biller_id = $Trans[2];
												$existstx->transactions_types_id = $Trans[3];
												$existstx->relatednumber = $Trans[6];
												$existstx->due_date = date('Y-m-d h:i:s', strtotime($Trans[7]));
												$existstx->arrival_date = date('Y-m-d h:i:s', strtotime($Trans[8]));
												$existstx->departure_date = date('Y-m-d h:i:s', strtotime($Trans[9]));
												$existstx->number = $Trans[5];
												$existstx->biz_area_id = $Trans[4];
												$existstx->payorrefnumber = $Trans[10];
												$existstx->transactions_status_id = $Trans[11];
												$existstx->save();
												
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 1;
												$importFailed->reason = "Row: $count:- Transaction Updated Successfully";
												$importFailed->save();
											}
										} else {
											if(is_numeric($Trans[1]) && is_numeric($Trans[2])) {
												$transaction = new Transaction();
												$transaction->amount = $Trans[0];
												$transaction->payor_id = $Trans[1];
												$transaction->biller_id = $Trans[2];
												$transaction->transactions_types_id = $Trans[3];
												$transaction->number = $Trans[5];
												$transaction->relatednumber = $Trans[6];
												$transaction->due_date = date('Y-m-d h:i:s', strtotime($Trans[7]));
												$transaction->arrival_date = date('Y-m-d h:i:s', strtotime($Trans[8]));
												$transaction->departure_date = date('Y-m-d h:i:s', strtotime($Trans[9]));
												$transaction->biz_area_id = $Trans[4];
												$transaction->payorrefnumber = $Trans[10];
												$transaction->transactions_status_id = $Trans[11];
												$transaction->save();
												
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 1;
												$importFailed->reason = "Row: $count:- Transaction Created Successfully";
												$importFailed->save();
												
											}else {
												$importFailed = new ImportFailed;
												$importFailed->company_name = $customerDetails->legal_name;
												$importFailed->import_date = date('Y-m-d H:i:s');
												$importFailed->file_name = $filename;
												$importFailed->status = 0;
												$importFailed->reason = "Inavlid payorId and billerId in Row:$count";
												$importFailed->save();
												$importFailure = 1;
												continue;
											}
											
										}
									}   
				                }catch (Exception $e) {
									continue;
								}
							} 
			                $count = $count + 1;
			            }
						if($importFailure == 1) {
							unlink($path);
						}
						if($importFailure == 0) {
							$sftp->delete('transactions/transactions_'.$ftpDetails->user_id . '/' . $filename);
							unlink($path);
						}
					}
				}
			}
			//Log::info('Import successfully');
			echo 'Import successfully';exit;
		  }//if time matches	
			//return Response::json(['success' => true,'msg' => 'Import Successfully.'], 200);
			
		}catch (Exception $e) {
		  //Log::info('There was an error'.$e);
			//return Response::json(['error' => true,'msg' => $e], 200);
		}
	endforeach;endif;
      }
}
