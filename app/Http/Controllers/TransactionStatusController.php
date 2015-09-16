<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Transaction;
use App\Models\TrxExport;
use App\Models\Customer;
use App\Models\BankAccount;
use App\Models\User;
use DB;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\ModelNotFoundException;
Use App\Models\TransactionHistory;
Use App\Models\TransactionStatus;
use Response;
use Input;
use Cache;
use Mail;

class TransactionStatusController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        //to optain all countrys
        if (Cache::has('transactions_status')) {
            return Cache::get('transactions_status');
        } else {
            $transactions_status = \App\Models\TransactionStatus::all();
            //return $transactions_status;
            Cache::put('transactions_status', $transactions_status, 5);
            return $transactions_status;
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create() {
        // 
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

        if (Cache::has('transactions_status_single')) {
            return Cache::get('transactions_status_single');
        } else {
            $transactions_status = \App\Models\TransactionStatus::find($id);
            //return $transactions_status;
            Cache::put('transactions_status_single', $transactions_status, 5);
            return $transactions_status;
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function edit($id) {
        //DB::enableQueryLog();

        $transaction = Transaction::findOrFail($id);
        $customer = Customer::findOrFail($transaction->payor_id);
        $baccount = BankAccount::where('customers_id', $transaction->payor_id)->get();

        if (count($baccount) != 0 && $baccount[0]->number != "" && $customer->legal_name != "") {
            $trxexport = new TrxExport;
            $trxexport->Payor_Name = $customer->legal_name;
            $trxexport->Payor_Address = $customer->address;
            $trxexport->Payor_Email = $customer->email;
            $trxexport->Payor_Phone = $customer->phone;
            $trxexport->Payor_City = ($customer->city_id != '') ? $customer->city_id : 0;
            $trxexport->Payor_State = ($customer->state_id != '') ? $customer->state_id : 0;
            $trxexport->Payee_is_PAB = ($transaction->biller_id != '') ? $transaction->biller_id : 0;
            $trxexport->Trx_Amount = $transaction->amount;
            $trxexport->Payor_Routing_Num = $baccount[0]->routing_number;
            $trxexport->Payor_Account_Num = $baccount[0]->number;
            $trxexport->Payor_Zip = $customer->zip_postal;
            $trxexport->export_batch_id = date("ymd-1");
            $trxexport->Last_Updated = date("Y-m-d H:i:s");
            $trxexports[] = $trxexport->attributesToArray();

            $trxexport = new TrxExport;
            $trxexport->Payor_Name = $customer->legal_name;
            $trxexport->Payor_Address = $customer->address;
            $trxexport->Payor_Email = $customer->email;
            $trxexport->Payor_Phone = $customer->phone;
            $trxexport->Payor_City = ($customer->city_id != '') ? $customer->city_id : 0;
            $trxexport->Payor_State = ($customer->state_id != '') ? $customer->state_id : 0;
            $trxexport->Payee_is_PAB = ($transaction->biller_id != '') ? $transaction->biller_id : 0;
            $trxexport->Trx_Amount = 2.00;
            $trxexport->Payor_Routing_Num = $baccount[0]->routing_number;
            $trxexport->Payor_Account_Num = $baccount[0]->number;
            $trxexport->Payor_Zip = $customer->zip_postal;
            $trxexport->export_batch_id = date("ymd-2");
            $trxexport->Last_Updated = date("Y-m-d H:i:s");
            $trxexports[] = $trxexport->attributesToArray();


            $trx_success = TrxExport::insert($trxexports);

            if ($trx_success) {
                $transaction->transactions_status_id = 2;
                if ($transaction->save()) {
                    return Response::json([
                                'success' => true,
                                'msg' => 'Transaction Verified Scucessfully.'
                                    ], 200);
                }
            }
        } else {
            return Response::json([
                        'success' => false,
                        'msg' => 'Failed to Verify.  Bank details does not exists.'
                            ], 200);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function update($id) {
        
    }

    function get_status_desc($id) {
        $TransactionStatus = TransactionStatus::find($id);
        return $TransactionStatus->description;
    }

    /**
     * @Approve a Tranasctions with dispute.
     * @accept: transaction id.
     * @return: boolean;
     * @author:iblesoft
     */
    public function verify($id, Request $request) {
        $transaction = Transaction::findOrFail($id);
        $customer = Customer::findOrFail($transaction->payor_id);
        $baccount = BankAccount::where('customers_id', $transaction->payor_id)->get();
        if (count($baccount) != 0 && $baccount[0]->number != "" && $customer->legal_name != "") {
            $trxexport = new TrxExport;
            $trxexport->Payor_Name = $customer->legal_name;
            $trxexport->Payor_Address = $customer->address;
            $trxexport->Payor_Email = $customer->email;
            $trxexport->Payor_Phone = $customer->phone;
            $trxexport->Payor_City = ($customer->city_id != '') ? $customer->city_id : 0;
            $trxexport->Payor_State = ($customer->state_id != '') ? $customer->state_id : 0;
            $trxexport->Payee_is_PAB = ($transaction->biller_id != '') ? $transaction->biller_id : 0;
            $trxexport->Trx_Amount = $transaction->amount;
            $trxexport->Payor_Routing_Num = $baccount[0]->routing_number;
            $trxexport->Payor_Account_Num = $baccount[0]->number;
            $trxexport->Payor_Zip = $customer->zip_postal;
            $trxexport->export_batch_id = date("ymd-1");
            $trxexport->export_txn_id = $id;
            $trxexport->Last_Updated = date("Y-m-d H:i:s");
            $trxexports[] = $trxexport->attributesToArray();

            $trxexport = new TrxExport;
            $trxexport->Payor_Name = $customer->legal_name;
            $trxexport->Payor_Address = $customer->address;
            $trxexport->Payor_Email = $customer->email;
            $trxexport->Payor_Phone = $customer->phone;
            $trxexport->Payor_City = ($customer->city_id != '') ? $customer->city_id : 0;
            $trxexport->Payor_State = ($customer->state_id != '') ? $customer->state_id : 0;
            $trxexport->Payee_is_PAB = ($transaction->biller_id != '') ? $transaction->biller_id : 0;
            $trxexport->Trx_Amount = 2.00;
            $trxexport->Payor_Routing_Num = $baccount[0]->routing_number;
            $trxexport->Payor_Account_Num = $baccount[0]->number;
            $trxexport->Payor_Zip = $customer->zip_postal;
            $trxexport->export_batch_id = date("ymd-2");
            $trxexport->export_txn_id = $id;
            $trxexport->Last_Updated = date("Y-m-d H:i:s");
            $trxexports[] = $trxexport->attributesToArray();
            //Inserting data in trx exports table.
            $trx_success = TrxExport::insert($trxexports);
            if ($trx_success) {
                $transaction->transactions_status_id = 2;
                if ($transaction->save()) {
                    //Adding transactions log
                    $history = new TransactionHistory;
                    $history->transactions_id = $id;
                    $history->field = 'Status';
                    $history->old_value = $this->get_status_desc(Input::get('transactions_status_id'));
                    $history->new_value = $this->get_status_desc(2);
                    $history->created_at = date('Y-m-d H:i:s');
                    $history->updated_at = date('Y-m-d H:i:s');
                    $history->action = 'Updated';
                    $history->users_id = $request->user_id;
                    $history->transactions_status_id = 2;
                    $history->payor_id = $transaction->payor_id;
                    $history->biller_id = $transaction->biller_id;
                    $history->biz_area_id = $transaction->biz_area_id;
                    $history->transactions_types_id = $transaction->transactions_types_id;
                    $history->save();
                    $current_user = User::where('id', $request->user_id)->first();
                    if ($current_user->customers_id == $transaction->payor_id) {
                        $customer_update_txn = Customer::where('id', $current_user->customers_id)->first();
                        $customer_receive_email = Customer::where('id', $transaction->biller_id)->first();
                    } else {
                        $customer_receive_email = Customer::where('id', $current_user->customers_id)->first();
                        $customer_update_txn = Customer::where('id', $transaction->biller_id)->first();
                    }
					$txn_url = '#/dashboard/transactionPdetails/'.$transaction->id;
					
                    $data = array('email' => $customer_receive_email->email, 'name' => $customer_update_txn->legal_name, 'customer_receive_name' => $customer_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);

                    Mail::send('emails.verifiedTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_url), function($message) use ($data) {
                        $message->to($data['email'], $data['customer_receive_name'])->subject('Verified Transaction/'. $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                    
                    //End of transactions log
                    return Response::json([
                                'success' => true,
                                'msg' => 'Transaction Verified Scucessfully.'
                                    ], 200);
                }
            }
        } else {
            return Response::json([
                        'success' => false,
                        'msg' => 'Failed to Verify.  Bank details does not exists.'
                            ], 200);
        }
    }

    public function pause($id, Request $request) {
        $transaction = Transaction::findOrFail($id);
        $customer = Customer::findOrFail($transaction->payor_id);
        $baccount = BankAccount::where('customers_id', $transaction->payor_id)->get();
        if (count($baccount) != 0 && $baccount[0]->number != "" && $customer->legal_name != "") {
            $trxexport = TrxExport::where('export_txn_id', $id)->delete();
            $header_nacha = DB::table('header_nacha')->where('batch_number', $id)->delete();
            $body_nacha = DB::table('body_nacha')->where('batch_number', $id)->delete();
            if ($trxexport && $header_nacha && $body_nacha) {
                $transaction->transactions_status_id = 5;
                if ($transaction->save()) {
                    //Adding transactions log
                    $history = new TransactionHistory;
                    $history->transactions_id = $id;
                    $history->field = 'Status';
                    $history->old_value = $this->get_status_desc(3);
                    $history->new_value = $this->get_status_desc(5);
                    $history->created_at = date('Y-m-d H:i:s');
                    $history->updated_at = date('Y-m-d H:i:s');
                    $history->action = 'Updated';
                    $history->users_id = $request->user_id;
                    $history->payor_id = $transaction->payor_id;
                    $history->biller_id = $transaction->biller_id;
                    $history->biz_area_id = $transaction->biz_area_id;
                    $history->transactions_types_id = $transaction->transactions_types_id;
                    $history->transactions_status_id = 5;
                    $history->save();
                    $current_user = User::where('id', $request->user_id)->first();
                    $customerB_receive_email = Customer::where('id', $transaction->biller_id)->first();
                    $data = array('email' => $customerB_receive_email->email, 'name' => $current_user->name, 'customer_receive_name' => $customerB_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);

                    Mail::send('emails.pausedTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name']), function($message) use ($data) {
                        $message->to($data['email'], $data['customer_receive_name'])->subject('Paused Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                    $customer_receiveP_email = Customer::where('id', $transaction->payor_id)->first();
					$txn_url = '#/dashboard/transactionPdetails/'.$transaction->id;
                    $data = array('email' => $customer_receiveP_email->email, 'name' => $current_user->name, 'customer_receive_name' => $customer_receiveP_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
					
                    Mail::send('emails.pausedTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_url), function($message) use ($data) {
                        $message->to($data['email'], $data['customer_receive_name'])->subject('Paused Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });

                    //End of transactions log
                    return Response::json([
                                'success' => true,
                                'msg' => 'Transaction Paused Scucessfully.'
                                    ], 200);
                }
            }
        } else {
            return Response::json([
                        'success' => false,
                        'msg' => 'Failed to Verify.  Bank details does not exists.'
                            ], 200);
        }
    }

    public function reapprove($id, Request $request) {
        $transaction = Transaction::findOrFail($id);
        $customer = Customer::findOrFail($transaction->payor_id);
        $baccount = BankAccount::where('customers_id', $transaction->payor_id)->get();
        if (count($baccount) != 0 && $baccount[0]->number != "" && $customer->legal_name != "") {
            $transaction->transactions_status_id = 1;
            if ($transaction->save()) {
                //Adding transactions log
                $history = new TransactionHistory;
                $history->transactions_id = $id;
                $history->field = 'Status';
                $history->old_value = $this->get_status_desc(5);
                $history->new_value = $this->get_status_desc(1);
                $history->created_at = date('Y-m-d H:i:s');
                $history->updated_at = date('Y-m-d H:i:s');
                $history->action = 'Updated';
                $history->users_id = $request->user_id;
                $history->payor_id = $transaction->payor_id;
                $history->biller_id = $transaction->biller_id;
                $history->biz_area_id = $transaction->biz_area_id;
                $history->transactions_types_id = $transaction->transactions_types_id;
                $history->transactions_status_id = 1;
                $history->save();
                $current_user = User::where('id', $request->user_id)->first();
                $customerB_receive_email = Customer::where('id', $transaction->biller_id)->first();
				$txn_urlB = '#/dashboard/transactionDetails/'.$transaction->id;
				$txn_urlP = '#/dashboard/transactionPdetails/'.$transaction->id;
                $data = array('email' => $customerB_receive_email->email, 'name' => $current_user->name, 'customer_receive_name' => $customerB_receive_email->legal_name,'number' =>$transaction->number, 'amount' =>$transaction->amount);

                Mail::send('emails.reapproveTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlB), function($message) use ($data) {
                    $message->to($data['email'], $data['customer_receive_name'])->subject('Re-Approve Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                });
                $customer_receiveP_email = Customer::where('id', $transaction->payor_id)->first();

                $data = array('email' => $customer_receiveP_email->email, 'name' => $current_user->name, 'customer_receive_name' => $customer_receiveP_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);

                Mail::send('emails.reapproveTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlP), function($message) use ($data) {
                    $message->to($data['email'], $data['customer_receive_name'])->subject('Re-Approve Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                });
                //End of transactions log
                return Response::json([
                            'success' => true,
                            'msg' => 'Transaction Paused Scucessfully.'
                                ], 200);
            }
        } else {
            return Response::json([
                        'success' => false,
                        'msg' => 'Failed to Verify.  Bank details does not exists.'
                            ], 200);
        }
    }
	//Cancel transaction from Directly from email.
	public function mailCancelTransaction($id,$user_id,$status) {
		$transaction = Transaction::findOrFail($id);
		$customer = Customer::findOrFail($transaction->payor_id);
		$baccount = BankAccount::where('customers_id', $transaction->payor_id)->get();
		if (count($baccount) != 0 && $baccount[0]->number != "" && $customer->legal_name != "") {
			if ($transaction->transactions_status_id == 3) {
				$header_nacha = DB::table('header_nacha')->where('batch_number', $id)->delete();
				$body_nacha = DB::table('body_nacha')->where('batch_number', $id)->delete();
				$trxexport = TrxExport::where('export_txn_id', $id)->delete();
			}
			$transaction->transactions_status_id = 7;
			if ($transaction->save()) {
				
				$history = new TransactionHistory;
				$history->transactions_id = $id;
				$history->field = 'Status';
				$history->old_value = $this->get_status_desc($status);
				$history->new_value = $this->get_status_desc(7);
				$history->created_at = date('Y-m-d H:i:s');
				$history->updated_at = date('Y-m-d H:i:s');
				$history->action = 'Updated';
				$history->users_id = $user_id;
				$history->reason_cancel = "Transaction is cancelled from email";
				$history->payor_id = $transaction->payor_id;
				$history->biller_id = $transaction->biller_id;
				$history->biz_area_id = $transaction->biz_area_id;
				$history->transactions_types_id = $transaction->transactions_types_id;
				$history->transactions_status_id = 7;
				$history->save();
				$current_user = User::where('id', $user_id)->first();
				
				$customerB_receive_email = Customer::where('id', $transaction->biller_id)->first();
				$customer_receiveP_email = Customer::where('id', $transaction->payor_id)->first();
				$txn_urlB = '#/dashboard/transactionDetails/'.$transaction->id;
				$txn_urlP = '#/dashboard/transactionPdetails/'.$transaction->id;
				
				if ($current_user->role_id == 8) {

					$data = array('email' => $customerB_receive_email->email, 'name' => $current_user->name, 'customer_receive_name' => $customerB_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
					Mail::send('emails.cancelTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlB), function($message) use ($data) {
						$message->to($data['email'], $data['customer_receive_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
					});

					$data = array('email' => $customer_receiveP_email->email, 'name' => $current_user->name, 'customer_receive_name' => $customer_receiveP_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
					Mail::send('emails.cancelTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlP), function($message) use ($data) {
						$message->to($data['email'], $data['customer_receive_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
					});
					return view('emails.cancelTxnviaEmail', ['msg' => 'A transaction has been canceled successfully']);
					//End of transactions log
					return Response::json([
								'success' => true,
								'msg' => 'Transaction Cancelled Scucessfully.'
									], 200);
				}
				if ($current_user->customers_id == $customerB_receive_email->id) {
					
					$data = array('email' => $customer_receiveP_email->email, 'name' => $customerB_receive_email->legal_name, 'customer_receive_name' => $customer_receiveP_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
					Mail::send('emails.cancelTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlP), function($message) use ($data) {
						$message->to($data['email'], $data['customer_receive_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
					});
					return view('emails.cancelTxnviaEmail', ['msg' => 'A transaction has been canceled successfully']);
					//End of transactions log
					return Response::json([
								'success' => true,
								'msg' => 'Transaction Cancelled Scucessfully.'
									], 200);
				}
				if ($current_user->customers_id == $customer_receiveP_email->id) {
					
					$data = array('email' => $customerB_receive_email->email, 'name' => $customer_receiveP_email->legal_name, 'customer_receive_name' => $customerB_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
					Mail::send('emails.cancelTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlB), function($message) use ($data) {
						$message->to($data['email'], $data['customer_receive_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
					});
					return view('emails.cancelTxnviaEmail', ['msg' => 'A transaction has been canceled successfully']);
					//End of transactions log
					return Response::json([
								'success' => true,
								'msg' => 'Transaction Cancelled Scucessfully.'
									], 200);
				}
			}
		}else {
			return view('emails.cancelTxnviaEmail', ['msg' => 'Failed to Verify.  Bank details does not exists.']);
		}
	}
    public function cancel($id, Request $request) {
        $transaction = Transaction::findOrFail($id);
        $customer = Customer::findOrFail($transaction->payor_id);
        $baccount = BankAccount::where('customers_id', $transaction->payor_id)->get();
        if (count($baccount) != 0 && $baccount[0]->number != "" && $customer->legal_name != "") {
            if ($transaction->transactions_status_id == 3) {
                $header_nacha = DB::table('header_nacha')->where('batch_number', $id)->delete();
                $body_nacha = DB::table('body_nacha')->where('batch_number', $id)->delete();
                $trxexport = TrxExport::where('export_txn_id', $id)->delete();
            }

            $transaction->transactions_status_id = 7;
            if ($transaction->save()) {
                //Adding transactions log
                $history = new TransactionHistory;
                $history->transactions_id = $id;
                $history->field = 'Status';
                $history->old_value = $this->get_status_desc(Input::get('transactions_status_id'));
                $history->new_value = $this->get_status_desc(7);
                $history->created_at = date('Y-m-d H:i:s');
                $history->updated_at = date('Y-m-d H:i:s');
                $history->action = 'Updated';
                $history->users_id = $request->user_id;
                $history->reason_cancel = $request->reason;
                $history->payor_id = $transaction->payor_id;
                $history->biller_id = $transaction->biller_id;
                $history->biz_area_id = $transaction->biz_area_id;
                $history->transactions_types_id = $transaction->transactions_types_id;
                $history->transactions_status_id = 7;
                $history->save();
                $current_user = User::where('id', $request->user_id)->first();
                $customerB_receive_email = Customer::where('id', $transaction->biller_id)->first();
                $customer_receiveP_email = Customer::where('id', $transaction->payor_id)->first();
				$txn_urlB = '#/dashboard/transactionDetails/'.$transaction->id;
				$txn_urlP = '#/dashboard/transactionPdetails/'.$transaction->id;
                if ($current_user->role_id == 8) {

                    $data = array('email' => $customerB_receive_email->email, 'name' => $current_user->name, 'customer_receive_name' => $customerB_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
                    Mail::send('emails.cancelTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlB), function($message) use ($data) {
                        $message->to($data['email'], $data['customer_receive_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });

                    $data = array('email' => $customer_receiveP_email->email, 'name' => $current_user->name, 'customer_receive_name' => $customer_receiveP_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
                    Mail::send('emails.cancelTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlP), function($message) use ($data) {
                        $message->to($data['email'], $data['customer_receive_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                    //End of transactions log
                    return Response::json([
                                'success' => true,
                                'msg' => 'Transaction Cancelled Scucessfully.'
                                    ], 200);
                }
                if ($current_user->customers_id == $customerB_receive_email->id) {
                    $data = array('email' => $customer_receiveP_email->email, 'name' => $customerB_receive_email->legal_name, 'customer_receive_name' => $customer_receiveP_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
                    Mail::send('emails.cancelTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlP), function($message) use ($data) {
                        $message->to($data['email'], $data['customer_receive_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                    //End of transactions log
                    return Response::json([
                                'success' => true,
                                'msg' => 'Transaction Cancelled Scucessfully.'
                                    ], 200);
                }
                if ($current_user->customers_id == $customer_receiveP_email->id) {
                    $data = array('email' => $customerB_receive_email->email, 'name' => $customer_receiveP_email->legal_name, 'customer_receive_name' => $customerB_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
                    Mail::send('emails.cancelTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_urlB), function($message) use ($data) {
                        $message->to($data['email'], $data['customer_receive_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                    //End of transactions log
                    return Response::json([
                                'success' => true,
                                'msg' => 'Transaction Cancelled Scucessfully.'
                                    ], 200);
                }
            }
        } else {
            return Response::json([
                        'success' => false,
                        'msg' => 'Failed to Verify.  Bank details does not exists.'
                            ], 200);
        }
    }
	function mailApproveTransaction($id) {
		
		$transaction = Transaction::findOrFail($id);
        $customer = Customer::findOrFail($transaction->payor_id);
        $baccount = BankAccount::where('customers_id', $transaction->payor_id)->get();
		if($transaction->transactions_status_id == 3) {
			return view('emails.approveTxnviaEmail', ['msg' => 'A transaction is already approved.']);
		}
		if($transaction->transactions_status_id == 7) {
			return view('emails.approveTxnviaEmail', ['msg' => 'Sorry Your transactions is already cancelled,we are unable to process.']);
		}
		if (count($baccount) != 0 && $baccount[0]->number != "" && $customer->legal_name != "") {
			$trxexport = new TrxExport;
            $trxexport->Payor_Name = $customer->legal_name;
            $trxexport->Payor_Address = $customer->address;
            $trxexport->Payor_Email = $customer->email;
            $trxexport->Payor_Phone = $customer->phone;
            $trxexport->Payor_City = ($customer->city_id != '') ? $customer->city_id : 0;
            $trxexport->Payor_State = ($customer->state_id != '') ? $customer->state_id : 0;
            $trxexport->Payee_is_PAB = ($transaction->biller_id != '') ? $transaction->biller_id : 0;
            $trxexport->Trx_Amount = $transaction->amount;
            $trxexport->Payor_Routing_Num = $baccount[0]->routing_number;
            $trxexport->Payor_Account_Num = $baccount[0]->number;
            $trxexport->Payor_Zip = $customer->zip_postal;
            $trxexport->export_batch_id = date("ymd-1");
            $trxexport->export_txn_id = $id;
            $trxexport->Last_Updated = date("Y-m-d H:i:s");
            $trxexports[] = $trxexport->attributesToArray();

            $trxexport = new TrxExport;
            $trxexport->Payor_Name = $customer->legal_name;
            $trxexport->Payor_Address = $customer->address;
            $trxexport->Payor_Email = $customer->email;
            $trxexport->Payor_Phone = $customer->phone;
            $trxexport->Payor_City = ($customer->city_id != '') ? $customer->city_id : 0;
            $trxexport->Payor_State = ($customer->state_id != '') ? $customer->state_id : 0;
            $trxexport->Payee_is_PAB = ($transaction->biller_id != '') ? $transaction->biller_id : 0;
            $trxexport->Trx_Amount = 2.00;
            $trxexport->Payor_Routing_Num = $baccount[0]->routing_number;
            $trxexport->Payor_Account_Num = $baccount[0]->number;
            $trxexport->Payor_Zip = $customer->zip_postal;
            $trxexport->export_batch_id = date("ymd-2");
            $trxexport->export_txn_id = $id;
            $trxexport->Last_Updated = date("Y-m-d H:i:s");
            $trxexports[] = $trxexport->attributesToArray();
            $trx_success = TrxExport::insert($trxexports);
			if ($trx_success) {
                $transaction->transactions_status_id = 3;
                $transaction->amount = $transaction->amount - $transaction->disputed_amount;
                if ($transaction->balance_dispute == 1) {
                    $trx_balance_pending = new Transaction;
                    $trx_balance_pending->biz_area_id = $transaction->biz_area_id;
                    $trx_balance_pending->number = $transaction->number;
                    $trx_balance_pending->relatednumber = $transaction->relatednumber;
                    $trx_balance_pending->creator = $transaction->creator;
                    $trx_balance_pending->transactions_types_id = $transaction->transactions_types_id;
                    $trx_balance_pending->departure_date = $transaction->departure_date;
                    $trx_balance_pending->arrival_date = $transaction->arrival_date;
                    $trx_balance_pending->due_date = $transaction->due_date;
                    $trx_balance_pending->amount = $transaction->disputed_amount;
                    $transaction->disputed_amount = 0;
                    $trx_balance_pending->balance_dispute = 1;
                    $trx_balance_pending->description = $transaction->description;
                    $trx_balance_pending->transactions_status_id = 1;
                    $trx_balance_pending->payorrefnumber = $transaction->payorrefnumber;
                    $trx_balance_pending->biller_id = $transaction->biller_id;
                    $trx_balance_pending->payor_id = $transaction->payor_id;
                    $trx_balance_pending->user_id = $transaction->user_id;
                    $trx_balance_pending->disputedrefnumber = $transaction->disputedrefnumber;
                    $trx_balance_pending->save();
					
                    $customer_receive_email = Customer::where('id', $transaction->payor_id)->first();
                    $customer_biller_email = Customer::where('id', $transaction->biller_id)->first();
					$txn_url = '#/dashboard/transactionDetails/'.$transaction->id;
                    $data = array('email' => $customer_receive_email->email, 'name' => $customer_biller_email->legal_name, 'payor_name' => $customer_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);

                    Mail::send('emails.txn_biller_balance', array('name' => $data['name'], 'email' => $data['email'], 'payor_name' => $data['payor_name'], 'number' => $data['number'],'txn_url' => $txn_url), function($message) use ($data) {
                        $message->to($data['email'], $data['payor_name'])->subject('New Pending Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                }
                if ($transaction->balance_dispute == 2) {
                    $trx_balance_pending = new Transaction;
                    $trx_balance_pending->biz_area_id = $transaction->biz_area_id;
                    $trx_balance_pending->number = $transaction->number;
                    $trx_balance_pending->relatednumber = $transaction->relatednumber;
                    $trx_balance_pending->creator = $transaction->creator;
                    $trx_balance_pending->transactions_types_id = $transaction->transactions_types_id;
                    $trx_balance_pending->departure_date = $transaction->departure_date;
                    $trx_balance_pending->arrival_date = $transaction->arrival_date;
                    $trx_balance_pending->due_date = $transaction->due_date;
                    $trx_balance_pending->amount = $transaction->disputed_amount;
                    $transaction->disputed_amount = 0;
                    $trx_balance_pending->balance_dispute = 2;
                    $trx_balance_pending->description = $transaction->description;
                    $trx_balance_pending->transactions_status_id = 7;
                    $trx_balance_pending->payorrefnumber = $transaction->payorrefnumber;
                    $trx_balance_pending->biller_id = $transaction->biller_id;
                    $trx_balance_pending->payor_id = $transaction->payor_id;
                    $trx_balance_pending->user_id = $transaction->user_id;
                    $trx_balance_pending->disputedrefnumber = $transaction->disputedrefnumber;
                    $trx_balance_pending->save();

                    $customer_receive_email = Customer::where('id', $transaction->payor_id)->first();
                    $customer_biller_email = Customer::where('id', $transaction->biller_id)->first();
					$txn_url = '#/dashboard/transactionDetails/'.$transaction->id;
                    $data = array('email' => $customer_receive_email->email, 'name' => $customer_biller_email->legal_name, 'payor_name' => $customer_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);

                    Mail::send('emails.txn_biller_balance', array('name' => $data['name'], 'email' => $data['email'], 'payor_name' => $data['payor_name'], 'number' => $data['number'],'txn_url' => $txn_url), function($message) use ($data) {
                        $message->to($data['email'], $data['payor_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                }
                if ($transaction->save()) {
                    //Adding transactions log
                    $history = new TransactionHistory;
                    $history->transactions_id = $id;
                    $history->field = 'Status';
                    $history->old_value = $this->get_status_desc(Input::get('transactions_status_id'));
                    $history->new_value = $this->get_status_desc(3);
                    $history->created_at = date('Y-m-d H:i:s');
                    $history->updated_at = date('Y-m-d H:i:s');
                    $history->action = 'Updated';
                    $history->users_id = $transaction->user_id;
                    $history->payor_id = $transaction->payor_id;
                    $history->biller_id = $transaction->biller_id;
                    $history->biz_area_id = $transaction->biz_area_id;
                    $history->transactions_types_id = $transaction->transactions_types_id;
                    $history->transactions_status_id = 3;
                    $history->save();

                    $current_user = User::where('id', $transaction->user_id)->first();
                    if ($current_user->customers_id == $transaction->payor_id) {
                        $customer_update_txn = Customer::where('id', $current_user->customers_id)->first();
                        $customer_receive_email = Customer::where('id', $transaction->biller_id)->first();
                    } else {
                        $customer_receive_email = Customer::where('id', $current_user->customers_id)->first();
                        $customer_update_txn = Customer::where('id', $transaction->biller_id)->first();
                    }
                    $data = array('email' => $customer_receive_email->email, 'name' => $customer_update_txn->legal_name, 'customer_receive_name' => $customer_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
					$txn_url = '#/dashboard/transactionDetails/'.$transaction->id;
                    Mail::send('emails.approvedTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_url), function($message) use ($data) {
                        $message->to($data['email'], $data['customer_receive_name'])->subject('Approved Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                    //End of transactions log
                    return view('emails.approveTxnviaEmail', ['msg' => 'A transaction has been approved successfully']);
                }
            }
		}else {
            return view('emails.approveTxnviaEmail', ['msg' => 'Failed to Verify.  Bank details does not exists.']);
        }
	}
    /**
     * @Approve a Tranasctions with dispute.
     * @accept: transaction id.
     * @return: boolean;
     * @author:iblesoft
     */
    public function approve_with_dispute($id, Request $request) {
		$transaction = Transaction::findOrFail($id);
        $customer = Customer::findOrFail($transaction->payor_id);
        $baccount = BankAccount::where('customers_id', $transaction->payor_id)->get();

        if (count($baccount) != 0 && $baccount[0]->number != "" && $customer->legal_name != "") {
            $trxexport = new TrxExport;
            $trxexport->Payor_Name = $customer->legal_name;
            $trxexport->Payor_Address = $customer->address;
            $trxexport->Payor_Email = $customer->email;
            $trxexport->Payor_Phone = $customer->phone;
            $trxexport->Payor_City = ($customer->city_id != '') ? $customer->city_id : 0;
            $trxexport->Payor_State = ($customer->state_id != '') ? $customer->state_id : 0;
            $trxexport->Payee_is_PAB = ($transaction->biller_id != '') ? $transaction->biller_id : 0;
            $trxexport->Trx_Amount = $transaction->amount;
            $trxexport->Payor_Routing_Num = $baccount[0]->routing_number;
            $trxexport->Payor_Account_Num = $baccount[0]->number;
            $trxexport->Payor_Zip = $customer->zip_postal;
            $trxexport->export_batch_id = date("ymd-1");
            $trxexport->export_txn_id = $id;
            $trxexport->Last_Updated = date("Y-m-d H:i:s");
            $trxexports[] = $trxexport->attributesToArray();

            $trxexport = new TrxExport;
            $trxexport->Payor_Name = $customer->legal_name;
            $trxexport->Payor_Address = $customer->address;
            $trxexport->Payor_Email = $customer->email;
            $trxexport->Payor_Phone = $customer->phone;
            $trxexport->Payor_City = ($customer->city_id != '') ? $customer->city_id : 0;
            $trxexport->Payor_State = ($customer->state_id != '') ? $customer->state_id : 0;
            $trxexport->Payee_is_PAB = ($transaction->biller_id != '') ? $transaction->biller_id : 0;
            $trxexport->Trx_Amount = 2.00;
            $trxexport->Payor_Routing_Num = $baccount[0]->routing_number;
            $trxexport->Payor_Account_Num = $baccount[0]->number;
            $trxexport->Payor_Zip = $customer->zip_postal;
            $trxexport->export_batch_id = date("ymd-2");
            $trxexport->export_txn_id = $id;
            $trxexport->Last_Updated = date("Y-m-d H:i:s");
            $trxexports[] = $trxexport->attributesToArray();
            $trx_success = TrxExport::insert($trxexports);
            if ($trx_success) {
                $transaction->transactions_status_id = 3;
                $transaction->amount = $transaction->amount - $transaction->disputed_amount;
                if ($request->balance_dispute == 1) {
                    $trx_balance_pending = new Transaction;
                    $trx_balance_pending->biz_area_id = $transaction->biz_area_id;
                    $trx_balance_pending->number = $transaction->number;
                    $trx_balance_pending->relatednumber = $transaction->relatednumber;
                    $trx_balance_pending->creator = $transaction->creator;
                    $trx_balance_pending->transactions_types_id = $transaction->transactions_types_id;
                    $trx_balance_pending->departure_date = $transaction->departure_date;
                    $trx_balance_pending->arrival_date = $transaction->arrival_date;
                    $trx_balance_pending->due_date = $transaction->due_date;
                    $trx_balance_pending->amount = $transaction->disputed_amount;
                    $transaction->disputed_amount = 0;
                    $trx_balance_pending->balance_dispute = 1;
                    $trx_balance_pending->description = $transaction->description;
                    $trx_balance_pending->transactions_status_id = 1;
                    $trx_balance_pending->payorrefnumber = $transaction->payorrefnumber;
                    $trx_balance_pending->biller_id = $transaction->biller_id;
                    $trx_balance_pending->payor_id = $transaction->payor_id;
                    $trx_balance_pending->user_id = $transaction->user_id;
                    $trx_balance_pending->disputedrefnumber = $transaction->disputedrefnumber;
                    $trx_balance_pending->save();
					
                    $customer_receive_email = Customer::where('id', $transaction->payor_id)->first();
                    $customer_biller_email = Customer::where('id', $transaction->biller_id)->first();
					$txn_url = '#/dashboard/transactionDetails/'.$transaction->id;
                    $data = array('email' => $customer_receive_email->email, 'name' => $customer_biller_email->legal_name, 'payor_name' => $customer_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);

                    Mail::send('emails.txn_biller_balance', array('name' => $data['name'], 'email' => $data['email'], 'payor_name' => $data['payor_name'], 'number' => $data['number'],'txn_url' => $txn_url), function($message) use ($data) {
                        $message->to($data['email'], $data['payor_name'])->subject('New Pending Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                }
                if ($request->balance_dispute == 2) {
                    $trx_balance_pending = new Transaction;
                    $trx_balance_pending->biz_area_id = $transaction->biz_area_id;
                    $trx_balance_pending->number = $transaction->number;
                    $trx_balance_pending->relatednumber = $transaction->relatednumber;
                    $trx_balance_pending->creator = $transaction->creator;
                    $trx_balance_pending->transactions_types_id = $transaction->transactions_types_id;
                    $trx_balance_pending->departure_date = $transaction->departure_date;
                    $trx_balance_pending->arrival_date = $transaction->arrival_date;
                    $trx_balance_pending->due_date = $transaction->due_date;
                    $trx_balance_pending->amount = $transaction->disputed_amount;
                    $transaction->disputed_amount = 0;
                    $trx_balance_pending->balance_dispute = 2;
                    $trx_balance_pending->description = $transaction->description;
                    $trx_balance_pending->transactions_status_id = 7;
                    $trx_balance_pending->payorrefnumber = $transaction->payorrefnumber;
                    $trx_balance_pending->biller_id = $transaction->biller_id;
                    $trx_balance_pending->payor_id = $transaction->payor_id;
                    $trx_balance_pending->user_id = $transaction->user_id;
                    $trx_balance_pending->disputedrefnumber = $transaction->disputedrefnumber;
                    $trx_balance_pending->save();

                    $customer_receive_email = Customer::where('id', $transaction->payor_id)->first();
                    $customer_biller_email = Customer::where('id', $transaction->biller_id)->first();
					$txn_url = '#/dashboard/transactionDetails/'.$transaction->id;
                    $data = array('email' => $customer_receive_email->email, 'name' => $customer_biller_email->legal_name, 'payor_name' => $customer_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);

                    Mail::send('emails.txn_biller_balance', array('name' => $data['name'], 'email' => $data['email'], 'payor_name' => $data['payor_name'], 'number' => $data['number'],'txn_url' => $txn_url), function($message) use ($data) {
                        $message->to($data['email'], $data['payor_name'])->subject('Cancelled Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                }
                if ($transaction->save()) {
                    //Adding transactions log
                    $history = new TransactionHistory;
                    $history->transactions_id = $id;
                    $history->field = 'Status';
                    $history->old_value = $this->get_status_desc(Input::get('transactions_status_id'));
                    $history->new_value = $this->get_status_desc(3);
                    $history->created_at = date('Y-m-d H:i:s');
                    $history->updated_at = date('Y-m-d H:i:s');
                    $history->action = 'Updated';
                    $history->users_id = $request->user_id;
                    $history->payor_id = $transaction->payor_id;
                    $history->biller_id = $transaction->biller_id;
                    $history->biz_area_id = $transaction->biz_area_id;
                    $history->transactions_types_id = $transaction->transactions_types_id;
                    $history->transactions_status_id = 3;
                    $history->save();

                    $current_user = User::where('id', $request->user_id)->first();
                    if ($current_user->customers_id == $transaction->payor_id) {
                        $customer_update_txn = Customer::where('id', $current_user->customers_id)->first();
                        $customer_receive_email = Customer::where('id', $transaction->biller_id)->first();
                    } else {
                        $customer_receive_email = Customer::where('id', $current_user->customers_id)->first();
                        $customer_update_txn = Customer::where('id', $transaction->biller_id)->first();
                    }
                    $data = array('email' => $customer_receive_email->email, 'name' => $customer_update_txn->legal_name, 'customer_receive_name' => $customer_receive_email->legal_name, 'number' =>$transaction->number, 'amount' =>$transaction->amount);
					$txn_url = '#/dashboard/transactionDetails/'.$transaction->id;
                    Mail::send('emails.approvedTxn', array('name' => $data['name'], 'email' => $data['email'], 'customer_receive_name' => $data['customer_receive_name'],'txn_url' => $txn_url), function($message) use ($data) {
                        $message->to($data['email'], $data['customer_receive_name'])->subject('Approved Transaction/' . $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
                    });
                    //End of transactions log
                    return Response::json([
                                'success' => true,
                                'msg' => 'Approved Transaction Scucessfully.'
                                    ], 200);
                }
            }
        } else {
            return Response::json([
                        'success' => false,
                        'msg' => 'Failed to Verify.  Bank details does not exists.'
                            ], 200);
        }
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
