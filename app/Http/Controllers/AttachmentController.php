<?php namespace App\Http\Controllers;

use App\Http\Requests;
use App\Http\Controllers\Controller;

//use Illuminate\Http\Request;
use Input;
use Request;
use Redirect;
use File;
use Exception;
use Mail;
use App\Models\Transaction;
use App\Models\Customer;
use App\Models\TransactionAttachment;
use DB;

class AttachmentController extends Controller {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
		return view('welcome');
		exit;		
	}
	
	public function getAttachments($transactions_id)
	{
		$db = new DB;
		
		$attachments = $db::table('transaction_attachments')
					->join('transactions_types', 'transaction_attachments.attachment_type', '=', 'transactions_types.id')
					->select('transaction_attachments.*', 'transactions_types.description as attachment_type_description', 
					'transaction_attachments.created as created_date')
					->where('transaction_id', $transactions_id)->get();
		return $attachments;	
		
	}
	
	/**
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */	
	public function deleteAttachment($id)
	{

		$attachment = TransactionAttachment::find(Input::get('attachment_id'));
		$filename = public_path().'/uploads/transaction_attachments/'.$attachment->file_name;
		if($attachment->delete()){
			if (File::exists($filename)) {
			    File::delete($filename);
			} 
		}		
		return response()->json([
			"success" => true,
			"msg" => 'File deleted perminantly from Uploads.',
				], 200
		);
		
	}
	
	
	/**
	 * Uploading file and inserting the record into transaction attachments.
	 * @return Response
	 */
	public function uploading()
	{
		//DB::enableQueryLog();	
		$files = Input::file($_FILES);
		$statusmessage = "";
		foreach ($files as $file)
		{
			$filename = str_random(6) . '_' . $file->getClientOriginalName();
			$fileext = ".".File::extension($filename);
			$txnid = Input::get('txnId');
			$userid = Input::get('customerId');
			$desc = Input::get('fileDescription');
			$atttype = Input::get('txnType');
			$destinationPath = public_path(). '/uploads/transaction_attachments';
			$created=  date('Y-m-d');
			$modified= date('Y-m-d');
			
			try
			{				
				$trans_attachments = TransactionAttachment::where('transaction_id','=', $txnid)->count();
				
				if($trans_attachments < 5)
				{
					$mfile = $file->move($destinationPath, $filename);				
					$transactionattc=new TransactionAttachment();
				
					$transactionattc->transaction_id			=	$txnid;
					$transactionattc->user_id					=	$userid;
					$transactionattc->file_path					=	$destinationPath;
					$transactionattc->attachment_type			=	$atttype;
					$transactionattc->description				=	$desc;
					$transactionattc->viewable_by_other_party	=	$txnid;
					$transactionattc->created					=	date('Y-m-d h:i:s',time());
					$transactionattc->modified					=	date('Y-m-d h:i:s',time());
					$transactionattc->active					=	1;
					$transactionattc->file_name					=	$filename;
					$transactionattc->file_extension			=	$fileext;
				
					$transactionattc->save(); 
					
						return response()->json([
	                        "success" => true,
	                        "msg" => 'File Upload Successfully!',
	                            ], 200
						);					
				}
				else
				{
					return response()->json([
                        "success" => false,
                        "msg" => 'File Upload limite is exceed You Can Upload only 5 Files!',
                            ], 200
					);
				}
			}
			catch(Exception $e)
			{
				echo "Failed";
			}
		}
	}
	/**
	 * @Desc: Sending attachment to email.
	 * @author: Iblesoft
	 * @inputs: attachment ID, Attachment Details
	 * @return boolean
	 */
	public function send_email($attachment)
	{
		$attachment = TransactionAttachment::find($attachment);
		$filename = public_path().'/uploads/transaction_attachments/'.$attachment->file_name;
		if (File::exists($filename)) {
			$trx = Transaction::find($attachment->transaction_id);
			
			$customer_current_id = $attachment->user_id;
			$customerDetails = Customer::find($customer_current_id);

			if($customer_current_id === $trx->biller_id){
				
				$receiver = $trx->payor_id;
			}else{
				$receiver = $trx->biller_id;
			}
			$receiver_details = Customer::find($receiver);
			$data = array(
				'email' 	 	 => $receiver_details->email,
				'legal_name' 	 => $receiver_details->legal_name,
				'trx_number' 	 => $trx->number
			);
			$sent = Mail::send('emails.attachment',
					array('name' => $data['legal_name'],'email'	=> "khadar3332@gmail.com", 'trx_number' => $data['trx_number'], 'file_name' => url('/uploads/transaction_attachments/' . $attachment->file_name)), function($message) use ($data) {
					$message->to("khadar3332@gmail.com", $data['legal_name'])->subject('Transaction Attachment');
					}
				);	
			return 1;
		} 	
	}
	
	
	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
	public function create()
	{
		
		
	}

	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store($request)
	{ 
	
	
	}
	function attachments()
	{
		try{
			return $_FILES['file']['name'];
		}catch (Exception $e) {
			return 0;
		}
	}
	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		
	}

	/**
	 * Show the form for editing the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		//
	}

	/**
	 * Update the specified resource in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		//
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		//
	}

}
