<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\TransactionDisputeDetail;
use App\Http\Controllers\Controller;
use App\Models\User;
Use App\Models\Transaction;
Use App\Models\TransactionHistory;
Use App\Models\TransactionStatus;
Use App\Models\Customer;
use Mail;
use Input;
use DB;
use Session;
use Response;
use Illuminate\Support\Facades\Auth;

class TransactionDisputeController extends Controller {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
    public function index() {
        $transaction_dispute = TransactionDisputeDetail::all();
        return $transaction_dispute;
    }
	function get_status_desc($id)
	{
		$TransactionStatus = TransactionStatus::find($id);
		return $TransactionStatus->description;
	}
	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
    public function create(Request $request) {
		
		//Saving dispute details in transactions_disputedetails table
		$disputeDetails = new TransactionDisputeDetail;
		$disputeDetails->transactions_id = Input::get('transactions_id');
		$disputeDetails->dispute_reasons_id = Input::get('disputeReasonId');
		$disputeDetails->dispute_categorys_id = Input::get('disputeCategoryId');
		$disputeDetails->description = Input::get('description');
		$disputeDetails->created_at = date("Y-m-d H:i:s");
		$disputeDetails->updated_at = date("Y-m-d H:i:s");
		$disputeDetails->active = 1;
		$disputeDetails->users_id = Input::get('customerId');
                $disputeDetails->save();
		
		//Saving transactions dispute details in transactins table withs tatus dipsute
		$trx = Transaction::find(Input::get('transactions_id'));
		$trx->transactions_status_id = 4;
		$trx->disputed_amount = Input::get('disputedAmount');
		$trx->disputedrefnumber = $disputeDetails->id;
		$trx->save();
		
		//Adding transactions log
		$history = new TransactionHistory;
		$history->transactions_id = Input::get('transactions_id');
		$history->field = 'Status';
		$history->old_value = $this->get_status_desc(1);
		$history->new_value = $this->get_status_desc(4);
		$history->created_at = date('Y-m-d H:i:s');
		$history->updated_at = date('Y-m-d H:i:s');
		$history->action = 'Updated';
		$history->users_id = Input::get('userId');
		$history->transactions_status_id = 4;
		$historyLog[] = $history->attributesToArray();
		
		$history->transactions_id = Input::get('transactions_id');
		$history->field = 'disputed Amount';
		$history->old_value = "";
		$history->new_value = Input::get('disputedAmount');
		$history->created_at = date('Y-m-d H:i:s');
		$history->updated_at = date('Y-m-d H:i:s');
		$history->action = 'Updated';
		$history->users_id = Input::get('userId');
		$history->transactions_status_id = 4;
		$historyLog[] = $history->attributesToArray();
		TransactionHistory::insert($historyLog);
		//$history->save();
		//End of transactions log
		
		
		//current logged in user.
		//$customer_current_id = Auth::user()->customers_id;
		$customer_current_id = Input::get('customerId');
		//Getting all information of Dispute creator who is created a dispute
		$dispute_cre = Customer::find($customer_current_id);
		if($customer_current_id == $trx->biller_id ){
			$exid = $trx->payor_id;
		}else{
			$exid = $trx->biller_id;
		}
		//Getting all information of Dispute Receiver who is disputed
		$dispute_rec = Customer::find($exid);
		//Retriving the dispute reason dynamically.
		$db = new DB;
		$reasons = DB::table('dispute_reasons')->where('id', $disputeDetails->dispute_reasons_id)->get();		
		$reasons = array_shift($reasons);
		$reason = $reasons->description;
		
		$data = array(
			'rec_email' 	 => $dispute_rec->email, //Email of Who is disputed  
			'rec_legal_name' => $dispute_rec->legal_name, //Name of who is disputed
			'cre_email' 	 => $dispute_cre->email, //Email of Who is disputed created
			'cre_legal_name' => $dispute_cre->legal_name, //Name of who is disputed
			'trx_number' 	 => $trx->number,
                        'amount' 	 => $trx->amount
		);
		
		//Sending mails to both parties
		$sent = Mail::send('emails.disputeDisputed',
					array('name' => $data['rec_legal_name'],'email'	=> $data['rec_email'], 'reason'	=> $reason,'byname'=> $data['cre_legal_name'],'trx_number' => $data['trx_number']), function($message) use ($data) {
					$message->to($data['rec_email'], $data['cre_legal_name'])->subject('Disputed Transaction/' . $data['byname'] .'/' .  $data['trx_number'] . '/$' .  $data['amount']);
					}
				);	
		Mail::send('emails.disputeCreated', 
			array('name' => $data['cre_legal_name'],'email' => $data['cre_email'],'trx_number' => $data['trx_number'],'disp_name'=> $data['rec_legal_name']), function($message) use ($data) {
			$message->to($data['cre_email'], $data['rec_legal_name'])->subject('Disputed Transaction/' . $data['disp_name'] .'/' .  $data['trx_number'] . '/$' .  $data['amount']);
			}	
		);
		return 1; 
    }
	public function disputeDetails($id)
	{
		$db = new DB;
		$disputeDetails = DB::table('transactions_disputedetails')->join('dispute_categorys', 'transactions_disputedetails.dispute_categorys_id', '=', 'dispute_categorys.id')->join('dispute_reasons', 'transactions_disputedetails.dispute_reasons_id', '=', 'dispute_reasons.id')->where('transactions_disputedetails.transactions_id', $id)->select('transactions_disputedetails.*', 'dispute_categorys.description as category_description', 'dispute_reasons.description as reason_description')->orderBy('transactions_disputedetails.id', 'desc')->get();
		return $disputeDetails;
	}
	
	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
    public function store() {
        //
    }

	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
    public function show($id) {
       $transaction_dispute = TransactionDisputeDetail::find($id);
        return $transaction_dispute;  
        //
    }

	/**
	 * Show the form for editing the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
    public function edit($id) {
        //
    }

	/**
	 * Update the specified resource in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
    public function update($id) {
        //
    }

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
    public function destroy($id) {
        //
    }

}
