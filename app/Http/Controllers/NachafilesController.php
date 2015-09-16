<?php namespace App\Http\Controllers;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\libraries\Nachalib\Nacha;
use DB;
use Response;
class NachafilesController extends Controller {
	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
		$nacha = new Nacha();
		$result = $nacha->setBankRT('123456789')// Your bank's routing number
					->setCompanyId('9876543210')// Usually your company Fed tax id with something the bank tells you to put on the front.
					->setSettlementAccount('44444444444') // Your bank account you want the money to go into
					->setFileID('9876543210')// Probably the same as your Company ID but your bank will tell you what this should be.
					->setOriginatingBank('BANK ON IT')// Text name of your bank
					->setFileModifier('A')// Usually just A - for the first file of the day.  Change to 'B' for second file of the day and so on.
					->setCompanyName('MY COMPANY')//16 chars - your company name
					->setBatchInfo('Monthly Subscriptions') // Text description for the batch
					->setDescription('Subscription', '06/1/2015') // Description shown on customers statements and date of invoice
					->setEntryDate(date('m/d/Y')
				); // The day you want the payments to be processed. This example shows today.  
			$payment = array(
				"AccountNumber"		=>'1234567', // The customer's CRM account number (not bank account number)
		        "TotalAmount"		=>30.00, // Amount they are paying you if it's a debit - or that you're paying them if it's a credit.
		        "BankAccountNumber"	=>'123456789', // Customer's bank account number
		        "RoutingNumber"		=>'987654321', // Customer's bank routing number
		        "FormattedName"		=>'Joe Smith', // Customer's name
		        "AccountType"		=> 'CHECKING', // Could be 'CHECKING' or 'SAVINGS' - customer's bank account type 
				'Transcode'			=> '1'
			); 
		// Add a debit - taking money from someone and puting it in your account
		if(!$nacha->addDebit($payment)){
		   // Error adding this debit.  Must be something wrong.  Check the $nacha->errorRecords.
		}
		// You can safely mix debits and credits in the same batch.
		// Add a credit - sending your money to someone elses bank account
		if(!$nacha->addCredit($payment)){
		   // Error adding this credit.  Must be something wrong.  Check the $nacha->errorRecords.
		}
		
		$nacha->generateFile();
		// Generate the NACHA file contents
		try{
			//echo app_path().'/Nachalib/';
			    // Put the file contents on the file system
			    if(!file_put_contents(app_path().'/libraries/Nachalib/nachafiles/ACH_MyCompany_NACHA_file.txt', $nacha->fileContents)){
			        throw new Exception('Unable to save NACHA file');
			    }
		}catch(Exception $e){
		    // Something went wrong with the file generation
		    print_r($e->getMessage());
		}	 		
	}
	public function create()
	{
		//DB::enableQueryLog();		
		$users =  DB::table('body_nacha')
					->join('header_nacha', 'body_nacha.batch_number', '=', 'header_nacha.batch_number')
					->join('customers', 'body_nacha.company_id', '=', 'customers.id')
					->where('header_nacha.effective_entry_date', '=',date('Y-m-d'))
					->get();
		if(empty($users))
		{
			return "<h3>There is no transactions verified on " . date('Y-m-d') . '<h3>';
		}
		$nacha = new Nacha();
		$nacha->setBankRT('062000019')// Your bank's routing number
		      ->setCompanyId('9876543210')// Usually your company Fed tax id with something the bank tells you to put on the front.
		      ->setSettlementAccount('44444444444') // Your bank account you want the money to go into
		      ->setFileID('9876543210')// Probably the same as your Company ID but your bank will tell you what this should be.
		      ->setOriginatingBank('Standard Federal Bank')// Text name of your bank
		      ->setFileModifier('A')// Usually just A - for the first file of the day.  Change to 'B' for second file of the day and so on.
		      ->setCompanyName('PAY ANY BIZ')//16 chars - your company name
		      ->setBatchInfo('Monthly Subscriptions') // Text description for the batch
		      ->setDescription('Subscription', '06/1/2015') // Description shown on customers statements and date of invoice
		      ->setEntryDate(date('m/d/Y')); // The day you want the payments to be processed. This example shows today. 
		
		if(!empty($users)) : foreach($users as $user) :
		
			$DebitAccount = DB::table('bankaccounts')->where('customers_id', '=', $user->id)->where('type', '=', 1)->first();
			$CreditAccount = DB::table('bankaccounts')->where('customers_id', '=', $user->id)->where('type', '=', 2)->first();
	
			$dpayment = array(
							"AccountNumber"		=> '1234567', // The customer's CRM account number (not bank account number)
							"TotalAmount"		=> $user->total_debit_amount, // Amount they are paying you if it's a debit - or that you're paying them if it's a credit.
							"BankAccountNumber"	=> $DebitAccount->number, // Customer's bank account number
							"RoutingNumber"		=> $DebitAccount->routing_number, // Customer's bank routing number
							"FormattedName"		=> $user->legal_name, // Customer's name
							"AccountType"		=> 'CHECKING', // Could be 'CHECKING' or 'SAVINGS' - customer's bank account type 
							'Transcode'			=> '27'
						); 		 
			$cpayment = array(
							"AccountNumber"		=> '1234567', // The customer's CRM account number (not bank account number)
							"TotalAmount"		=> $user->total_credit_amount, // Amount they are paying you if it's a debit - or that you're paying them if it's a credit.
							"BankAccountNumber"	=> $CreditAccount->number,// Customer's bank account number
							"RoutingNumber"		=> $CreditAccount->routing_number, // Customer's bank routing number
							"FormattedName"		=> $user->legal_name, // Customer's name
							"AccountType"		=> 'CHECKING', // Could be 'CHECKING' or 'SAVINGS' - customer's bank account type 
							'Transcode'			=> '22'
						); 	
			// Add a debit - taking money from someone and puting it in your account
			if(!$nacha->addDebit($dpayment)){
			   // Error adding this debit.  Must be something wrong.  Check the $nacha->errorRecords.
			}
			// You can safely mix debits and credits in the same batch.
			// Add a credit - sending your money to someone elses bank account
			if(!$nacha->addCredit($cpayment)){
			   // Error adding this credit.  Must be something wrong.  Check the $nacha->errorRecords.
			}
		endforeach;endif;
		// Generate the NACHA file contents
		try{
			$nacha->generateFile();
			if (!is_dir(app_path().'/libraries/Nachalib/nachafiles/')) {
				if (!mkdir(app_path().'/libraries/Nachalib/nachafiles/', 0777)) {
					echo "<h3>Error while creating directory Please contact administrator</h3>";
					exit;
				}
			}
			//if (file_exists(app_path().'/libraries/Nachalib/nachafiles/ACH_'.date('Ymd').'.txt')) {
			//	return "<h3>NACHA file is already exists.</h3>";
			//} 
			
			// Put the file contents on the file system
			if(!file_put_contents(app_path().'/libraries/Nachalib/nachafiles/ACH_'.date('Ymd').'.txt', $nacha->fileContents)){
				throw new Exception('Unable to save NACHA file');
			}else
			{
				return "<h3>NACHA file created successfully.</h3><a href='/download' style='text-decoration:none;'><h4>DOWNLOAD</h4></a>";
				
			}
		}catch(Exception $e){
			// Something went wrong with the file generation
			print_r($e->getMessage());
		}
	}
	function download()
	{
		$file = app_path().'/libraries/Nachalib/nachafiles/ACH_'.date('Ymd').'.txt';
        return Response::download($file);
	}
}
