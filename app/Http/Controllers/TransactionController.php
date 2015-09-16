<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\User;
use Response;
Use App\Models\Transaction;
Use App\Models\Customer;
Use App\Models\TransactionHistory;
Use App\Models\TransactionType;
Use App\Models\BizArea;
Use App\Models\TransactionStatus;
Use App\Models\BillerActivationToken;
Use App\Models\PayorActivationToken;
use Mail;
use Input;
use DB;
use Cache;

class TransactionController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        //to optain all transactions
        $transactions = Transaction::all();
        return $transactions;
    }

    /*     * *
     * Get Search Result for Biller Transactions
     * */

    public function searchTxtBiller(Request $request) {
        //DB::enableQueryLog(); //Un comment this line to print SQL Query		 

        $query = DB::table('transactions')
                ->leftJoin('customers', 'transactions.payor_id', '=', 'customers.id')
                ->leftJoin('transactions_types', 'transactions.transactions_types_id', '=', 'transactions_types.id')
                ->leftJoin('biz_areas', 'transactions.biz_area_id', '=', 'biz_areas.id')
                ->where('transactions.biller_id', '=', $request->biller_id);

        if ($request->category) {
            $query->where('biz_area_id', $request->category);
        }
        if ($request->type) {
            $query->where('transactions_types_id', $request->type);
        }
        if ($request->number) {
            $query->where('number', $request->number);
        }
        if ($request->rnumber) {
            $query->where('relatednumber', $request->rnumber);
        }
        if ($request->payor) {
            $query->where('payor_id', $request->payor);
        }
        if ($request->dueDateFromCol && $request->dueDateToCol) {

            $start = date('Y-m-d h:i:s', strtotime($request->dueDateFromCol));
            $end = date('Y-m-d h:i:s', strtotime($request->dueDateToCol));
            $query->whereBetween('due_date', array($start, $end));
        }
        if ($request->transactions_status_id) {
            $query->where('transactions_status_id', $request->transactions_status_id);
        }
        $query->select('transactions.*', 'customers.legal_name', 'transactions_types.description as type_desc', 'biz_areas.biz_area_description');

        $searchResults = $query->get();
        //print_r(DB::getQueryLog());
        return $searchResults;
    }

    public function countAllBillerTxt($biller_id) {
        $count_all_transactions = Transaction::where('biller_id', $biller_id)->count();
        return $count_all_transactions;
    }

    public function countPendingBillerTxt($biller_id) {
        $count_pending_transaction = Transaction::whereRaw('biller_id = ' . $biller_id . ' and transactions_status_id = 1')->count();
        return $count_pending_transaction;
    }

    public function countVerifiedBillerTxt($biller_id) {
        $count_verified_transaction = Transaction::whereRaw('biller_id = ' . $biller_id . ' and transactions_status_id = 2')->count();
        return $count_verified_transaction;
    }

    public function countApprovedBillerTxt($biller_id) {
        $count_approved_transaction = Transaction::whereRaw('biller_id = ' . $biller_id . ' and transactions_status_id = 3')->count();
        return $count_approved_transaction;
    }

    public function countDisputedBillerTxt($biller_id) {
        $count_disputed_transaction = Transaction::whereRaw('biller_id = ' . $biller_id . ' and transactions_status_id = 4')->count();
        return $count_disputed_transaction;
    }

    /*     * *
     * Get Search Result for Payor Transactions
     * */

    public function searchTxtPayor(Request $request) {
        //DB::enableQueryLog();
        $query = DB::table('transactions')
                ->leftJoin('customers', 'transactions.biller_id', '=', 'customers.id')
                ->leftJoin('transactions_types', 'transactions.transactions_types_id', '=', 'transactions_types.id')
                ->leftJoin('biz_areas', 'transactions.biz_area_id', '=', 'biz_areas.id')
                ->where('transactions.payor_id', '=', $request->payor_id);

        if ($request->category) {
            $query->where('biz_area_id', $request->category);
        }
        if ($request->type) {
            $query->where('transactions_types_id', $request->type);
        }
        if ($request->number) {
            $query->where('number', $request->number);
        }
        if ($request->rnumber) {
            $query->where('relatednumber', $request->rnumber);
        }
        if ($request->biller) {
            $query->where('biller_id', $request->biller);
        }
        if ($request->dueDateFromCol && $request->dueDateToCol) {

            $start = date('Y-m-d h:i:s', strtotime($request->dueDateFromCol));
            $end = date('Y-m-d h:i:s', strtotime($request->dueDateToCol));
            $query->whereBetween('due_date', array($start, $end));
        }
        if ($request->transactions_status_id) {
            $query->where('transactions_status_id', $request->transactions_status_id);
        }
        $query->select('transactions.*', 'customers.legal_name', 'transactions_types.description as type_desc', 'biz_areas.biz_area_description');

        $searchResults = $query->get();
        //print_r(DB::getQueryLog());
        return $searchResults;
    }

    public function searchTxtCustomer(Request $request) {
        //DB::enableQueryLog();
        $query = DB::table('transactions')
                ->join('customers', 'transactions.biller_id', '=', 'customers.id')
                ->join('transactions_types', 'transactions.transactions_types_id', '=', 'transactions_types.id')
                ->join('biz_areas', 'transactions.biz_area_id', '=', 'biz_areas.id')
                ->get();

        if ($request->category) {
            $query->where('biz_area_id', $request->category);
        }
        if ($request->type) {
            $query->where('transactions_types_id', $request->type);
        }
        if ($request->number) {
            $query->where('number', $request->number);
        }
        if ($request->rnumber) {
            $query->where('relatednumber', $request->rnumber);
        }
        if ($request->biller) {
            $query->where('biller_id', $request->biller);
        }
        if ($request->payor_id) {
            $query->where('payor_id', $request->payor_id);
        }
        if ($request->dueDateFromCol && $request->dueDateToCol) {

            $start = date('Y-m-d h:i:s', strtotime($request->dueDateFromCol));
            $end = date('Y-m-d h:i:s', strtotime($request->dueDateToCol));
            $query->whereBetween('due_date', array($start, $end));
        }
        if ($request->transactions_status_id) {
            $query->where('transactions_status_id', $request->transactions_status_id);
        }
        $query->select('transactions.*', 'customers.legal_name', 'transactions_types.description as type_desc', 'biz_areas.biz_area_description');

        $searchResults = $query->get();
        //print_r(DB::getQueryLog());
        return $searchResults;
    }

    public function countAllPayorTxt($payor_id) {
        $count_all_transactions = Transaction::where('payor_id', $payor_id)->count();
        return $count_all_transactions;
    }

    public function countPendingPayorTxt($payor_id) {
        $count_pending_transaction = Transaction::whereRaw('payor_id = ' . $payor_id . ' and transactions_status_id = 1')->count();
        return $count_pending_transaction;
    }

    public function countVerifiedPayorTxt($payor_id) {
        $count_verified_transaction = Transaction::whereRaw('payor_id = ' . $payor_id . ' and transactions_status_id = 2')->count();
        return $count_verified_transaction;
    }

    public function countApprovedPayorTxt($payor_id) {
        $count_approved_transaction = Transaction::whereRaw('payor_id = ' . $payor_id . ' and transactions_status_id = 3')->count();
        return $count_approved_transaction;
    }

    public function countDisputedPayorTxt($payor_id) {
        $count_disputed_transaction = Transaction::whereRaw('payor_id = ' . $payor_id . ' and transactions_status_id = 4')->count();
        return $count_disputed_transaction;
    }

    public function transactionLog($transaction_id, $details_of_log) {
        $history = new TransactionHistory;
        $history->transactions_id = $transaction_id;
        $history->field = $details_of_log['field'];
        $history->old_value = $details_of_log['old_value'];
        $history->new_value = $details_of_log['new_value'];
        $history->created_at = $details_of_log['created_at'];
        $history->updated_at = $details_of_log['updated_at'];
        $history->action = $details_of_log['action'];
        $history->users_id = $details_of_log['users_id'];
        $history->reason_cancel = $details_of_log['reason_cancel'];
        $history->biller_id = $details_of_log['biller_id'];
        $history->payor_id = $details_of_log['payor_id'];
        $history->biz_area_id = $details_of_log['biz_area_id'];
        $history->transactions_types_id = $details_of_log['transactions_types_id'];
        $history->transactions_status_id = $details_of_log['transactions_status_id'];
        $history->save();
    }

    public function validateFieldValue($transaction_id, $field, $fieldValue) {
        $transactions = new Transaction();
        $result = Transaction::where('id', $transaction_id)->get();
        $result = Transaction::whereRaw(" $field = " . $fieldValue)->get();
        return $result;
    }
	public function autoSaveBiller()
	{
		try {
			if(Input::get('id') == '') {
				$transactions = new Transaction();
				$all_txn = Transaction::all();
				$transactions->biller_id = Input::get('customer_current');
		        $transactions->payor_id = Input::get('mycurrentcustomer');
		        $allways_customer = Input::get('alwayscurrentcustomer');
				$user_biller_transaction = User::where('customers_id', $allways_customer)->first();
				if ($transactions->biller_id == $allways_customer) {
					foreach ($all_txn as $txns) {
						if ($txns->number == Input::get('number') && Input::get('number') != '') {
		                    return response()->json(["error" => true,'number' => 2], 200);
		                }
		            }				
					$transactions->user_id 			= $user_biller_transaction->id;
		            $transactions->creator 			= $user_biller_transaction->id;
		            $transactions->transactions_types_id = Input::get('myTransatype');
		            $transactions->transactions_status_id = 8;
		            $transactions->number 			= Input::get('number');
		            $transactions->amount 			= Input::get('amount');
		            $transactions->due_date 		= Input::get('due_date');
		            $transactions->biz_area_id 		= Input::get('myArea');
		            $transactions->relatednumber	= Input::get('relatednumber');
		            $transactions->departure_date 	= Input::get('departure_date');
		            $transactions->arrival_date 	= Input::get('arrival_date');
		            $transactions->payorrefnumber 	= Input::get('payorrefnumber');
		            $transactions->description 		= Input::get('description');
		            $transactions->save();
					return $transactions;
				}else if ($transactions->payor_id == $allways_customer) {
					foreach ($all_txn as $txns) {
						if ($txns->number == Input::get('number') && Input::get('number') != '') {
								return response()->json(["error" => true,'number' => 2], 200);
						}
					}
					$transactions->user_id = $user_biller_transaction->id;
					$transactions->creator = $user_biller_transaction->id;
					$transactions->transactions_types_id = Input::get('myTransatype');
					$transactions->transactions_status_id = Input::get('transactions_status_id');
					$transactions->number = Input::get('number');
					$transactions->amount = Input::get('amount');
					$transactions->due_date = Input::get('due_date');
					$transactions->biz_area_id = Input::get('myArea');
					$transactions->relatednumber = Input::get('relatednumber');
					$transactions->departure_date = Input::get('departure_date');
					$transactions->arrival_date = Input::get('arrival_date');
					$transactions->payorrefnumber = Input::get('payorrefnumber');
					$transactions->description = Input::get('description');
					$transactions->save();
					return $transactions;
				}
			}else {
				$transactions = Transaction::find(Input::get('id'));
				$transactions->biller_id = Input::get('customer_current');
		        $transactions->payor_id = Input::get('mycurrentcustomer');
		        $allways_customer = Input::get('alwayscurrentcustomer');
				$user_biller_transaction = User::where('customers_id', $allways_customer)->first();
				$transactions->user_id 			= $user_biller_transaction->id;
				$transactions->creator 			= $user_biller_transaction->id;
				$transactions->transactions_types_id = Input::get('myTransatype');
				$transactions->transactions_status_id = Input::get('transactions_status_id');
				$transactions->number 			= Input::get('number');
				$transactions->amount 			= Input::get('amount');
				$transactions->due_date 		= Input::get('due_date');
				$transactions->biz_area_id 		= Input::get('myArea');
				$transactions->relatednumber	= Input::get('relatednumber');
				$transactions->departure_date 	= Input::get('departure_date');
				$transactions->arrival_date 	= Input::get('arrival_date');
				$transactions->payorrefnumber 	= Input::get('payorrefnumber');
				$transactions->description 		= Input::get('description');
				$transactions->active 			= 1;
				$transactions->save();
				if($transactions->biller_id == $allways_customer && Input::get('transactions_status_id') == 1)
				{	
					$biller_create_txn_id = $transactions->biller_id;
		            $customer_invite = Customer::find($biller_create_txn_id);
		            $payor_receive_txn_id = $transactions->payor_id;
		            $payor_invite_txn = Customer::find($payor_receive_txn_id);
					
					$txn_url = '#/dashboard/transactionDetails/'.$transactions->id;
				
					$mailSub = 'New In pending Transaction/';
					
					$biller_create_txn_id = $transactions->biller_id;
					$customer_invite = Customer::find($biller_create_txn_id);
					$payor_receive_txn_id = $transactions->payor_id;
					$payor_invite_txn = Customer::find($payor_receive_txn_id);
					//For mail
					$transaction_status_mail = $transactions->transactions_status_id;
					$user_id_mail = $transactions->user_id;
					$transactions_id_mail = $transactions->id;
					
					$data = array(
						'email' => $payor_invite_txn->email,
						'name' 	=> $customer_invite->legal_name,
						'payor_name' => $payor_invite_txn->legal_name,
						'number' => $transactions->number,
						'amount' => $transactions->amount,
						'mailSub' => $mailSub,
						'transaction_status_mail' => $transaction_status_mail,
						'user_id_mail' => $user_id_mail,
						'transactions_id_mail' => $transactions_id_mail
					);						
					Mail::send('emails.txn_biller', array(
						'name' 	=> $data['name'],
						'email' => $data['email'],
						'payor_name' => $data['payor_name'],
						'url' => '',
						'txn_url' => $txn_url,
						'transaction_status_mail' => $data['transaction_status_mail'],
						'user_id_mail' => $data['user_id_mail'],
						'transactions_id_mail' => $data['transactions_id_mail']
					), function($message) use ($data) {
						$message->to($data['email'], $data['payor_name'])->subject($data['mailSub'] .''. $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
					});
				}
				if($transactions->payor_id == $allways_customer && Input::get('transactions_status_id') == 1)
				{
					
					$biller_create_txn_id = $transactions->biller_id;
		            $customer_invite = Customer::find($biller_create_txn_id);
		            $payor_receive_txn_id = $transactions->payor_id;
		            $payor_invite_txn = Customer::find($payor_receive_txn_id);
					
					$txn_url = '#/dashboard/transactionPdetails/'.$transactions->id;
			
					if($transactions->transactions_status_id == 1) {
						$mailSub = 'New Pending Transaction/';
					}else {
						$mailSub = 'New In progress Transaction/';
					}
					//For mail
					$transaction_status_mail = $transactions->transactions_status_id;
					$user_id_mail = $transactions->user_id;
					$transactions_id_mail = $transactions->id;
					
		            $data = array(
						'email' => $customer_invite->email,
						'name' => $payor_invite_txn->legal_name,
						'payor_name' => $customer_invite->legal_name,
						'number' =>$transactions->number,
						'amount' =>$transactions->amount,
						'mailSub' => $mailSub,
						'transaction_status_mail' => $transaction_status_mail,
						'user_id_mail' => $user_id_mail,
						'transactions_id_mail' => $transactions_id_mail
					);
		            Mail::send('emails.txn_payor', array(
						'name' => $data['name'],
						'email' => $data['email'],
						'payor_name' => $data['payor_name'],
						'url' => '',
						'txn_url' => $txn_url,
						'transaction_status_mail' => $data['transaction_status_mail'],
						'user_id_mail' => $data['user_id_mail'],
						'transactions_id_mail' => $data['transactions_id_mail']
						), function($message) use ($data) {
		                $message->to($data['email'], $data['payor_name'])->subject($data['mailSub'] .''. $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
		            });
				}
				
				
	            return response()->json(["success" => true,"id" => $transactions->id,], 200);
			}
			//print_r($_REQUEST);exit;
		}catch (Exception $e) {
			return 0;
		}
	}
    /**
	     * Show the form for creating a new resource.
	     *
	     * @return Response
	*/
    public function create(Request $request) {
        
		$isEmpty = $this->validateTransactionValuesEmptyOrNot($request);
		//DB::enableQueryLog();
        $transactions = new Transaction();

        $history = new TransactionHistory;
        $all_txn = Transaction::all();
        $transactions->biller_id = $request->customer_current;
        $transactions->payor_id = $request->mycurrentcustomer;
        $allways_customer = $request->alwayscurrentcustomer;

        //find user relation biller      
        $user_biller_transaction = User::where('customers_id', $allways_customer)->first();
		//        if ($user_biller_transaction == null) {
		//            $transactions->user_id = null;
		//        }
		//        if ($user_biller_transaction != null) {
		//            $transactions->user_id = $user_biller_transaction->id;
		//            $transactions->creator = $user_biller_transaction->id;
		//        }
		//        if ($request->number != null) {
		//            foreach ($all_txn as $txns) {
		//                if ($txns->biller_id == $request->customer_current && $txns->number == $request->number) {
		//                    return response()->json([
		//                                "error" => true,
		//                                'number' => 2
		//                                    ], 400
		//                    );
		//                }
		//            }
		//        }
        if ($transactions->biller_id == $allways_customer) {
            foreach ($all_txn as $txns) {
                if ($txns->number == $request->number) {
                    return response()->json([
                                "error" => true,
                                'number' => 2
                                    ], 200
                    );
                }
            }
			
            $transactions->user_id = $user_biller_transaction->id;
            $transactions->creator = $user_biller_transaction->id;
            $transactions->transactions_types_id = $request->myTransatype;
            $transactions->transactions_status_id = ($isEmpty == 1) ? 8 : 1;
            $transactions->number = $request->number;
            $transactions->amount = $request->amount;
            $transactions->due_date = $request->due_date;
            $transactions->biz_area_id = $request->myArea;
            $transactions->relatednumber = $request->relatednumber;
            $transactions->departure_date = $request->departure_date;
            $transactions->arrival_date = $request->arrival_date;
            $transactions->payorrefnumber = $request->payorrefnumber;
            $transactions->description = $request->description;
            $transactions->save();

            //Transactions log
            $log_data = array(
                'field' => '',
                'old_value' => '',
                'new_value' => '',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s'),
                'action' => 'Created',
                'users_id' => $user_biller_transaction->id,
                'reason_cancel' => '',
                'biller_id' => $transactions->biller_id,
                'payor_id' => $transactions->payor_id,
                'biz_area_id' => $transactions->biz_area_id,
                'transactions_types_id' => $transactions->transactions_types_id,
                'transactions_status_id' => ($isEmpty == 1) ? 8 : 1
            );
            $this->transactionLog($transactions->id, $log_data);
            //End of transctions log

            $biller_create_txn_id = $transactions->biller_id;
            $customer_invite = Customer::find($biller_create_txn_id);
            $payor_receive_txn_id = $transactions->payor_id;
            $payor_invite_txn = Customer::find($payor_receive_txn_id);

            //Create Activation token to activate the account
            $activation_token = new BillerActivationToken;
            $activation_token->biller_id = $biller_create_txn_id;
            $activation_token->token = md5(uniqid(date('mdYhis'), true));

            $activation_token->save();

            $activation_url = url('/PayAnyBiz/ActivationBiller', ['token' => $activation_token->token]);
			
			$txn_url = '#/dashboard/transactionDetails/'.$transactions->id;
			if($transactions->transactions_status_id == 1) {
				$mailSub = 'New Pending Transaction/';
			}else {
				$mailSub = 'New In progress Transaction/';
			}
			
            $data = array('email' => $payor_invite_txn->email, 'name' => $customer_invite->legal_name, 'payor_name' => $payor_invite_txn->legal_name, 'number' =>$transactions->number, 'amount' =>$transactions->amount, 'mailSub' => $mailSub);

            Mail::send('emails.txn_biller', array('name' => $data['name'], 'email' => $data['email'], 'payor_name' => $data['payor_name'], 'url' => $activation_url,'txn_url' => $txn_url), function($message) use ($data) {
                $message->to($data['email'], $data['payor_name'])->subject($data['mailSub'] .''. $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
            });

            return response()->json([
                        "success" => true,
                        "id" => $transactions->id,
                            ], 200
            );
        } else if ($transactions->payor_id == $allways_customer) {
              foreach ($all_txn as $txns) {
                if ($txns->number == $request->number) {
                    return response()->json([
                                "error" => true,
                                'number' => 2
                                    ], 400
                    );
                }
            }
            $transactions->user_id = $user_biller_transaction->id;
            $transactions->creator = $user_biller_transaction->id;
            $transactions->transactions_types_id = $request->myTransatype;
            $transactions->transactions_status_id = ($isEmpty == 1) ? 8 : 1;
            $transactions->number = $request->number;
            $transactions->amount = $request->amount;
            $transactions->due_date = $request->due_date;
            $transactions->biz_area_id = $request->myArea;
            $transactions->relatednumber = $request->relatednumber;
            $transactions->departure_date = $request->departure_date;
            $transactions->arrival_date = $request->arrival_date;
            $transactions->payorrefnumber = $request->payorrefnumber;
            $transactions->description = $request->description;
            $transactions->save();

            //Transactions log
            $log_data = array(
                'field' => '',
                'old_value' => '',
                'new_value' => '',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s'),
                'action' => 'Created',
                'users_id' => $user_biller_transaction->id,
                'reason_cancel' => '',
                'biller_id' => $transactions->biller_id,
                'payor_id' => $transactions->payor_id,
                'biz_area_id' => $transactions->biz_area_id,
                'transactions_types_id' => $transactions->transactions_types_id,
                'transactions_status_id' => ($isEmpty == 1) ? 8 : 1
            );
            $this->transactionLog($transactions->id, $log_data);

            //End of transctions log

            $biller_create_txn_id = $transactions->biller_id;
            $customer_invite = Customer::find($biller_create_txn_id);
            $payor_receive_txn_id = $transactions->payor_id;
            $payor_invite_txn = Customer::find($payor_receive_txn_id);

            //Create Activation token to activate the account
            $activation_token = new PayorActivationToken;
            $activation_token->payor_id = $payor_receive_txn_id;
            $activation_token->token = md5(uniqid(date('mdYhis'), true));

            $activation_token->save();

            $activation_url = url('/PayAnyBiz/ActivationBiller', ['token' => $activation_token->token]);
			
			$txn_url = '#/dashboard/transactionPdetails/'.$transactions->id;
			
			if($transactions->transactions_status_id == 1) {
				$mailSub = 'New Pending Transaction/';
			}else {
				$mailSub = 'New In progress Transaction/';
			}
			
            $data = array('email' => $customer_invite->email, 'name' => $payor_invite_txn->legal_name, 'payor_name' => $customer_invite->legal_name, 'number' =>$transactions->number, 'amount' =>$transactions->amount,'mailSub' => $mailSub);

            Mail::send('emails.txn_payor', array('name' => $data['name'], 'email' => $data['email'], 'payor_name' => $data['payor_name'], 'url' => $activation_url,'txn_url' => $txn_url), function($message) use ($data) {
                $message->to($data['email'], $data['payor_name'])->subject($data['mailSub'] .''. $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
            });

            return response()->json([
                        "success" => true,
                        "id" => $transactions->id,
                            ], 200
            );
        }
    }
	
	public function validateTransactionValuesEmptyOrNot($formInputs)
	{
		try {
			$formvalues = array(
				'myTransatype'		=> $formInputs->transactions_types_id,
				'number'			=> $formInputs->number,
				'amount'			=> $formInputs->amount,
				'due_date'			=> $formInputs->due_date,
				'myArea'			=> $formInputs->biz_area_id,
				'relatednumber'		=> $formInputs->relatednumber,
				'departure_date'	=> $formInputs->departure_date,
				'payorrefnumber'	=> $formInputs->payorrefnumber,
				'description'		=> $formInputs->description
			);
			$count = 0;if(!empty($formvalues)) : foreach($formvalues as $key => $value) : 
				if(empty($value)) {
					$count = 1;
					return $count;
				}
			endforeach;endif;
			return $count;
		}catch (Exception $e) {
			return 1;
		}
	}

    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store(Request $request) {
//         $transactions = new Transaction();
//        // $input = Request::only('username','name','email','active','createdon','modifiedon','connections_id','image_profile', 'lastname');
//        $transactions->biller_id = $request->customer_current;
//        $transactions->payor_id = $request->mycurrentcustomer;
//        $customer_id = $transactions->biller_id;
//
//        //find user relation biller
//        $user_biller_transaction = User::where('customers_id', $customer_id)->first();
//        // $user_transaction = User::find($user_biller_transaction->id);
//        $transactions->user_id = $user_biller_transaction->id;
//        $transactions->transactions_types_id = $request->myTransatype;
//        $transactions->transactions_status_id = 1;
//        $transactions->number = $request->number;
//        $transactions->amount = $request->amount;
//        $transactions->due_date = $request->due_date;
//        $transactions->biz_area_id = $request->myArea;
//        $transactions->relatednumber = $request->relatednumber;
//        $transactions->departure_date = $request->departure_date;
//        $transactions->arrival_date = $request->arrival_date;
//        $transactions->payorrefnumber = $request->payorrefnumber;
//        $transactions->description = $request->description;
//        $transactions->save();
//
//        return response()->json([
//                    "msg" => "Success",
//                    "id" => $transactions->id,
//                        ], 200
//        );
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id) {
        $transactions = Transaction::find($id);
        return $transactions;
    }

    /*     * Start The below two functions written by Iblesoft** */

    public function joinTab($id) {
        $text = DB::table('transactions')
                        ->join('transactions_types', 'transactions_types.id', '=', 'transactions.transactions_types_id')
                        ->join('biz_areas', 'biz_areas.id', '=', 'transactions.biz_area_id')
                        ->join('transactions_status', 'transactions_status.id', '=', 'transactions.transactions_status_id')
                        ->join('customers', 'customers.id', '=', 'transactions.payor_id')
                        ->select('transactions.*', 'biz_areas.biz_area_description', 'transactions_status.description as transaction_status', 'customers.legal_name', "customers.address", "customers.phone", "customers.fax", 'transactions_types.description')
                        ->where('transactions.id', '=', $id)->get();
        return $text;
    }

    public function printAll($id) {
        $text = DB::table('transactions')
                ->join('transactions_types', 'transactions_types.id', '=', 'transactions.transactions_types_id')
                ->join('biz_areas', 'biz_areas.id', '=', 'transactions.biz_area_id')
                ->join('transactions_status', 'transactions_status.id', '=', 'transactions.transactions_status_id')
                ->join('customers', 'customers.id', '=', 'transactions.payor_id')
                ->select('transactions.*', 'biz_areas.biz_area_description', 'transactions_status.description as transaction_status', 'customers.legal_name')
                ->get();
        return $text;
    }

    /*     * End The below two functions written by Iblesoft** */

    /* Start The below two functions written by Iblesoft */

    public function print_transactions_details($id) {

        $transactions = DB::table('transactions')
                        ->join('transactions_types', 'transactions_types.id', '=', 'transactions.transactions_types_id')
                        ->join('biz_areas', 'biz_areas.id', '=', 'transactions.biz_area_id')
                        ->join('transactions_status', 'transactions_status.id', '=', 'transactions.transactions_status_id')
                        ->join('customers', 'customers.id', '=', 'transactions.payor_id')
                        ->select('transactions.*', 'biz_areas.biz_area_description', 'transactions_status.description as 
						transaction_status', 'customers.legal_name', "customers.address", "customers.phone", "customers.fax", 'transactions_types.description')
                        ->where('transactions.id', '=', $id)->get();

        return $transactions;
    }

    public function print_transactions_details_payor($id) {

        $transactions = DB::table('transactions')
                        ->join('transactions_types', 'transactions_types.id', '=', 'transactions.transactions_types_id')
                        ->join('biz_areas', 'biz_areas.id', '=', 'transactions.biz_area_id')
                        ->join('transactions_status', 'transactions_status.id', '=', 'transactions.transactions_status_id')
                        ->join('customers', 'customers.id', '=', 'transactions.biller_id')
                        ->select('transactions.*', 'biz_areas.biz_area_description', 'transactions_status.description as 
					transaction_status', 'customers.legal_name', "customers.address", "customers.phone", "customers.fax", 'transactions_types.description')
                        ->where('transactions.id', '=', $id)->get();

        return $transactions;
    }

    public function print_all_biller($id) {

        $transactions = DB::table('transactions')
                        ->join('transactions_types', 'transactions_types.id', '=', 'transactions.transactions_types_id')
                        ->join('biz_areas', 'biz_areas.id', '=', 'transactions.biz_area_id')
                        ->join('transactions_status', 'transactions_status.id', '=', 'transactions.transactions_status_id')
                        ->join('customers', 'customers.id', '=', 'transactions.biller_id')
                        ->select('transactions.*', 'biz_areas.biz_area_description', 'transactions_status.description as 
					transaction_status', 'customers.legal_name')
                        ->where('transactions.payor_id', '=', $id)->get();

        return $transactions;
    }

    public function print_all_payor($id) {

        $transactions = DB::table('transactions')
                ->join('transactions_types', 'transactions_types.id', '=', 'transactions.transactions_types_id')
                ->join('biz_areas', 'biz_areas.id', '=', 'transactions.biz_area_id')
                ->join('transactions_status', 'transactions_status.id', '=', 'transactions.transactions_status_id')
                ->join('customers', 'customers.id', '=', 'transactions.payor_id')
                ->where('transactions.biller_id', '=', $id)
                ->select('transactions.*', 'biz_areas.biz_area_description', 'transactions_status.description as 
					transaction_status', 'customers.legal_name', 'customers.type_customer')
                ->get();

        return $transactions;
    }
	
	public function print_req_transactions() {
		
		if(Input::get('customer_id') != '' || Input::get('customer_id_1') != '') {
		$transactions = DB::table('transactions')
		->join('transactions_types', 'transactions_types.id', '=', 'transactions.transactions_types_id')
		->join('biz_areas', 'biz_areas.id', '=', 'transactions.biz_area_id')
		->join('transactions_status', 'transactions_status.id', '=', 'transactions.transactions_status_id')
		->join('customers', 'customers.id', '=', 'transactions.biller_id')
		->whereIn('transactions.biller_id', array(Input::get('customer_id'), Input::get('customer_id_1')))
		->select('transactions.*', 'biz_areas.biz_area_description', 'transactions_status.description as 
			transaction_status', 'customers.legal_name', 'customers.type_customer');
		if(Input::get('stat')){
			$transactions->where('transactions.transactions_status_id', Input::get('stat'));
		}
		return $transactions->get();
		}else {
			$transactions = DB::table('transactions')
			->join('transactions_types', 'transactions_types.id', '=', 'transactions.transactions_types_id')
			->join('biz_areas', 'biz_areas.id', '=', 'transactions.biz_area_id')
			->join('transactions_status', 'transactions_status.id', '=', 'transactions.transactions_status_id')
			->join('customers', 'customers.id', '=', 'transactions.biller_id')
			->select('transactions.*', 'biz_areas.biz_area_description', 'transactions_status.description as 
				transaction_status', 'customers.legal_name', 'customers.type_customer');
			if(Input::get('stat')){
				$transactions->where('transactions.transactions_status_id', Input::get('stat'));
			}
			return $transactions->get();
		}
		if(Input::get('customer_id')){
			if(Input::get('typebiller')=="Payor"){
				$type = 'transactions.payor_id';
			}
			else{
				$type = 'transactions.biller_id';
			}
			$query = DB::table('transactions');
                $query->join('transactions_types', 'transactions_types.id', '=', 'transactions.transactions_types_id')
                ->join('biz_areas', 'biz_areas.id', '=', 'transactions.biz_area_id')
                ->join('transactions_status', 'transactions_status.id', '=', 'transactions.transactions_status_id')
                ->join('customers', 'customers.id', '=', 'transactions.payor_id')
                ->where($type, '=', Input::get('customer_id'))
                ->select('transactions.*', 'biz_areas.biz_area_description', 'transactions_status.description as 
					transaction_status', 'customers.legal_name', 'customers.type_customer');
				if(Input::get('stat')){
					$query->where('transactions.transactions_status_id', Input::get('stat'));
				}
			return $query->get();
		}
		else{
			$query = DB::table('transactions');
			if(Input::get('stat')){
				$query->where('transactions.transactions_status_id', Input::get('stat'));
			}
			return $query->get();
		}
    }

    function get_history($transaction_id) {
        $history = DB::table('transaction_history')
                ->join('users', 'users.id', '=', 'transaction_history.users_id')
                ->join('transactions', 'transactions.id', '=', 'transaction_history.transactions_id')
                ->join('customers', 'customers.id', '=', 'transaction_history.biller_id')
                ->join('customers as payor', 'payor.id', '=', 'transaction_history.payor_id')
                ->join('biz_areas', 'biz_areas.id', '=', 'transaction_history.biz_area_id')
                ->join('transactions_types', 'transactions_types.id', '=', 'transaction_history.transactions_types_id')
                ->select('transaction_history.*', 'users.username as modifiedBy', 'transactions.number as txnNumber', 'transactions.amount as txnAmount', 'transactions.due_date as txnDueDate', 'transactions.departure_date as txnDptreDate', 'transactions.arrival_date as txnArvaDate', 'biz_areas.biz_area_description as bizArea', 'transactions_types.description as txnType', 'customers.legal_name as billerName', 'payor.legal_name as payorName')
                ->where('transaction_history.transactions_id', '=', $transaction_id)
                ->whereNotIn('transaction_history.transactions_status_id', [4])
                ->orderBy('transaction_history.id', 'desc')
                ->get();
        return $history;
    }

    function dispute_history($transaction_id) {
        $history = DB::table('transaction_history')
                ->join('users', 'users.id', '=', 'transaction_history.users_id')
                ->select('transaction_history.*', 'users.username as modifiedBy')
                ->where('transaction_history.transactions_id', '=', $transaction_id)
                ->where('transaction_history.transactions_status_id', '=', 4)
                ->orderBy('transaction_history.id', 'desc')
                ->get();
        return $history;
    }

    function get_transaction_type_desc($id) {
        $TransactionType = TransactionType::find($id);
        return $TransactionType->description;
    }

    function get_biz_area_desc($id) {
        $biz_area_description = BizArea::find($id);
        return $biz_area_description->biz_area_description;
    }

    function get_status_desc($id) {
        $TransactionStatus = TransactionStatus::find($id);
        return $TransactionStatus->description;
    }

    /* End The below two functions written by Iblesoft  */

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
    public function update($id, Request $request) {
       // $isEmpty = $this->validateTransactionValuesEmptyOrNot($request);
		
		$transactions = Transaction::find($id);
        $transactions->biller_id = Input::get('biller_id');
        $transactions->payor_id = Input::get('payor_id');
        $customer_id = $transactions->biller_id;
        $allways_customer = $request->alwayscurrentcustomer;
        //find user relation biller
        $user_online = $request->user_id;
        $user_biller_transaction = User::where('customers_id', $customer_id)->first();
        // $user_transaction = User::find($user_biller_transaction->id);
        if ($user_biller_transaction == null) {
            $transactions->user_id = null;
        } else {
            $transactions->user_id = $user_biller_transaction->id;
        }
        if ($transactions->biller_id == $allways_customer) {

            if ($transactions->number != Input::get('number')) {
                $log_data = array(
                    'field' => 'number',
                    'old_value' => $transactions->number,
                    'new_value' => Input::get('number'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }
            if ($transactions->transactions_types_id != Input::get('transactions_types_id')) {
                $log_data = array(
                    'field' => 'Transaction Type',
                    'old_value' => $this->get_transaction_type_desc($transactions->transactions_types_id),
                    'new_value' => $this->get_transaction_type_desc(Input::get('transactions_types_id')),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }

            if ($transactions->amount != Input::get('amount')) {
                $log_data = array(
                    'field' => 'Amount',
                    'old_value' => $transactions->amount,
                    'new_value' => Input::get('amount'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }

            if ($transactions->due_date != Input::get('due_date')) {
                $log_data = array(
                    'field' => 'Due Date',
                    'old_value' => $transactions->due_date,
                    'new_value' => date('Y-m-d H:i:s', strtotime(Input::get('due_date'))),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }

            if ($transactions->relatednumber != Input::get('relatednumber')) {
                $log_data = array(
                    'field' => 'Related No.',
                    'old_value' => $transactions->relatednumber,
                    'new_value' => Input::get('relatednumber'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'reason_cancel' => 'Not canceled',
                    'users_id' => $user_online,
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }

            if ($transactions->departure_date != Input::get('departure_date')) {
                $log_data = array(
                    'field' => 'Departure Date',
                    'old_value' => $transactions->departure_date,
                    'new_value' => date('Y-m-d H:i:s', strtotime(Input::get('departure_date'))),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }

            if ($transactions->arrival_date != Input::get('arrival_date')) {
                $log_data = array(
                    'field' => 'Arrival Date',
                    'old_value' => $transactions->arrival_date,
                    'new_value' => date('Y-m-d H:i:s', strtotime(Input::get('arrival_date'))),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }

            if ($transactions->payorrefnumber != Input::get('payorrefnumber')) {
                $log_data = array(
                    'field' => 'Payor Ref Number',
                    'old_value' => $transactions->payorrefnumber,
                    'new_value' => Input::get('payorrefnumber'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }

            if ($transactions->biz_area_id != Input::get('biz_area_id')) {
                $log_data = array(
                    'field' => 'Category',
                    'old_value' => $this->get_biz_area_desc($transactions->biz_area_id),
                    'new_value' => $this->get_biz_area_desc(Input::get('biz_area_id')),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }

            if ($transactions->description != Input::get('description')) {
                $log_data = array(
                    'field' => 'Description',
                    'old_value' => $transactions->description,
                    'new_value' => Input::get('description'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }
            if ($transactions->transactions_status_id != Input::get('transactions_status_id')) {
                $log_data = array(
                    'field' => 'Status',
                    'old_value' => $this->get_status_desc($transactions->transactions_status_id),
                    'new_value' => $this->get_status_desc(Input::get('transactions_status_id')),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($transactions->id, $log_data);
            }

            if ($transactions->transactions_status_id == 2 && $transactions->amount != Input::get('amount')) {
                $transactions->transactions_status_id = 1;
            } else {
                
				$transactions->transactions_status_id = Input::get('transactions_status_id');
			}

            $transactions->transactions_types_id = Input::get('transactions_types_id');
            $transactions->number = Input::get('number');
            $transactions->amount = Input::get('amount');
            $transactions->due_date = Input::get('due_date');
            $transactions->biz_area_id = Input::get('biz_area_id');
            $transactions->relatednumber = Input::get('relatednumber');
            $transactions->departure_date = Input::get('departure_date');
            $transactions->arrival_date = Input::get('arrival_date');
            $transactions->payorrefnumber = Input::get('payorrefnumber');
            $transactions->description = $request->description;
            $transactions->save();

            $biller_create_txn_id = Input::get('biller_id');
            $customer_invite = Customer::find($biller_create_txn_id);
            $payor_receive_txn_id = Input::get('payor_id');
            $payor_invite_txn = Customer::find($payor_receive_txn_id);
            $data = array('email' => $payor_invite_txn->email, 'name' => $customer_invite->legal_name, 'payor_name' => $payor_invite_txn->legal_name, 'number' =>$transactions->number, 'amount' =>$transactions->amount);

            Mail::send('emails.updatedTxn', array('name' => $data['name'], 'email' => $data['email'], 'payor_name' => $data['payor_name']), function($message) use ($data) {
                $message->to($data['email'], $data['payor_name'])->subject('Updated Transaction /'. $data['name'] .'/'. $data['number'] . '/$' . $data['amount']);
            });
            return response()->json([
                        "success" => true,
                        "id" => $transactions->id,
                            ], 200
            );

        } else {


            if ($transactions->number != Input::get('number')) {
                $log_data = array(
                    'field' => 'number',
                    'old_value' => $transactions->number,
                    'new_value' => Input::get('number'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'biller_id' => $transactions->biller_id,
                    'reason_cancel' => 'Not canceled',
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }
            if ($transactions->transactions_types_id != Input::get('transactions_types_id')) {
                $log_data = array(
                    'field' => 'Transaction Type',
                    'old_value' => $this->get_transaction_type_desc($transactions->transactions_types_id),
                    'new_value' => $this->get_transaction_type_desc(Input::get('transactions_types_id')),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }

            if ($transactions->amount != Input::get('amount')) {
                $log_data = array(
                    'field' => 'Amount',
                    'old_value' => $transactions->amount,
                    'new_value' => Input::get('amount'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }

            if ($transactions->due_date != Input::get('due_date')) {
                $log_data = array(
                    'field' => 'Due Date',
                    'old_value' => $transactions->due_date,
                    'new_value' => date('Y-m-d H:i:s', strtotime(Input::get('due_date'))),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }

            if ($transactions->relatednumber != Input::get('relatednumber')) {
                $log_data = array(
                    'field' => 'Related No.',
                    'old_value' => $transactions->relatednumber,
                    'new_value' => Input::get('relatednumber'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }

            if ($transactions->departure_date != Input::get('departure_date')) {
                $log_data = array(
                    'field' => 'Departure Date',
                    'old_value' => $transactions->departure_date,
                    'new_value' => date('Y-m-d H:i:s', strtotime(Input::get('departure_date'))),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }

            if ($transactions->arrival_date != Input::get('arrival_date')) {
                $log_data = array(
                    'field' => 'Arrival Date',
                    'old_value' => $transactions->arrival_date,
                    'new_value' => date('Y-m-d H:i:s', strtotime(Input::get('arrival_date'))),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }

            if ($transactions->payorrefnumber != Input::get('payorrefnumber')) {
                $log_data = array(
                    'field' => 'Payor Ref Number',
                    'old_value' => $transactions->payorrefnumber,
                    'new_value' => Input::get('payorrefnumber'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }

            if ($transactions->biz_area_id != Input::get('biz_area_id')) {
                $log_data = array(
                    'field' => 'Category',
                    'old_value' => $this->get_biz_area_desc($transactions->biz_area_id),
                    'new_value' => $this->get_biz_area_desc(Input::get('biz_area_id')),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }

            if ($transactions->description != Input::get('description')) {
                $log_data = array(
                    'field' => 'Description',
                    'old_value' => $transactions->description,
                    'new_value' => Input::get('description'),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }
            if ($transactions->transactions_status_id != Input::get('transactions_status_id')) {
                $log_data = array(
                    'field' => 'Status',
                    'old_value' => $this->get_status_desc($transactions->transactions_status_id),
                    'new_value' => $this->get_status_desc(Input::get('transactions_status_id')),
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s'),
                    'action' => 'Updated',
                    'users_id' => $user_online,
                    'reason_cancel' => 'Not canceled',
                    'biller_id' => $transactions->biller_id,
                    'payor_id' => $transactions->payor_id,
                    'biz_area_id' => ($transactions->biz_area_id == '') ? 0 : $transactions->biz_area_id,
                    'transactions_types_id' => ($transactions->transactions_types_id == '') ? 0 : $transactions->transactions_types_id,
                    'transactions_status_id' => Input::get('transactions_status_id')
                );
                $this->transactionLog($id, $log_data);
            }
			
			if(Input::get('transactions_status_id') == 8 && $isEmpty == 0) {
				$transactions->transactions_status_id = 1;
			}else { 
				$transactions->transactions_status_id = Input::get('transactions_status_id');
			}
            $transactions->user_id = $user_online;
            $transactions->transactions_types_id = Input::get('transactions_types_id');
            $transactions->number = Input::get('number');
            $transactions->amount = Input::get('amount');
            $transactions->due_date = Input::get('due_date');
            $transactions->biz_area_id = Input::get('biz_area_id');
            $transactions->relatednumber = Input::get('relatednumber');
            $transactions->departure_date = Input::get('departure_date');
            $transactions->arrival_date = Input::get('arrival_date');
            $transactions->payorrefnumber = Input::get('payorrefnumber');
            $transactions->description = $request->description;
            $transactions->save();

            $biller_create_txn_id = Input::get('biller_id');
            $customer_invite = Customer::find($biller_create_txn_id);
            $payor_receive_txn_id = Input::get('payor_id');
            $payor_invite_txn = Customer::find($payor_receive_txn_id);
            $data = array('email' => $customer_invite->email, 'name' => $payor_invite_txn->legal_name, 'payor_name' => $customer_invite->legal_name, 'number' =>$transactions->number, 'amount' =>$transactions->amount);

            Mail::send('emails.updatedTxn', array('name' => $data['name'], 'email' => $data['email'], 'payor_name' => $data['payor_name']), function($message) use ($data) {
                $message->to($data['email'], $data['payor_name'])->subject('Updated Transaction/'. $data['name'] .'/' .  $data['number'] . '/$' .  $data['amount']);
            });
            return response()->json([
                        "success" => true,
                        "id" => $transactions->id,
                            ], 200
            );
        }
    }

    public function countAllPending() {
        $pending = Transaction::where('transactions_status_id', 1)->count();
        return $pending;
    }

    public function countAllVerified() {
        $verified = Transaction::where('transactions_status_id', 2)->count();
        return $verified;
    }

    public function countAllApproved() {
        $approved = Transaction::where('transactions_status_id', 3)->count();
        return $approved;
    }

    public function countAllDisputed() {
        $dispute = Transaction::where('transactions_status_id', 4)->count();
        return $dispute;
    }

    public function countAllCanceled() {
        $canceled = Transaction::where('transactions_status_id', 7)->count();
        return $canceled;
    }

    public function countAllPaused() {
        $pause = Transaction::where('transactions_status_id', 5)->count();
        return $pause;
    }

    public function verifyCreatorTxn($id) {
//          Transaction::whereRaw('biller_id = ' . $biller_id . ' and transactions_status_id = 1')->count();
        $pending = Transaction::find($id);
        return Response::json([
                    'success' => true,
                    'pending' => $pending
                        ], 200);
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
