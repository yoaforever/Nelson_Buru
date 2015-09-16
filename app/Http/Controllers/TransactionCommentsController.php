<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\User;
Use App\Models\TransactionComment;
Use App\Models\Customer;
Use App\Models\BillerActivationToken;
Use App\Models\PayorActivationToken;
use App\Models\Transaction;
use Mail;
use Input;
use Response;
use DB;

class TransactionCommentsController extends Controller {

    public function index() {
        //to optain all transactions
        $transactions = TransactionComment::all();
        return $transactions;
    }

    public function create() {
        $trx = new \App\Models\TransactionComment();
        $trx->transactions_id = Input::get('transactionId');
        $trx->customers_id = Input::get('customerId');
        $trx->comment = Input::get('comments');
        $trx->created_at = date('Y-m-d H:i:s');
        $trx->updated_at = date('Y-m-d H:i:s');
        $trx->active = true;
        $trx->users_id = Input::get('userId');
        $trx->save();
//        return 1;
        //Fetching transaction detsils of comment posted
        $get_trx = Transaction::find($trx->transactions_id);

        //Fetching biller details of comment posted
        $comment_biller = Customer::find($get_trx->biller_id);

        //Fetching payour details of comment posted
        $comment_payor = Customer::find($get_trx->payor_id);

        if ($get_trx->biller_id == Input::get('customerId')) {
            $commentator = $comment_biller;
            $receive_email = $comment_payor;
        } else {
            $commentator = $comment_payor;
            $receive_email = $comment_biller;
        }
//		$commentator = Customer::find($trx->customers_id);


        /*         * * Sending email to other party when a comment posted under a transaction by Iblesoft* */
        $data = array(
            'comment' => $trx->comment,
            'commentator_name' => $commentator->legal_name,
            'receive_name' => $receive_email->legal_name,
            'commentator_email' => $commentator->email,
            'receive_email' => $receive_email->email,
            'trx_number' => $get_trx->number, 
            'amount' => $get_trx->amount
        );

        Mail::send('emails.disputeComment', $data, function($message) use ($data) {
            $message->to($data['receive_email'], $data['receive_name'])->subject('Response with Answer/'.  $data['trx_number'] . '/$' .  $data['amount']);
        });
        

    }

    public function getComments($trx_id) {
        $query = DB::table('transactionscomments')
                ->join('customers', 'transactionscomments.customers_id', '=', 'customers.id')
                ->join('users', 'transactionscomments.users_id', '=', 'users.id')
                ->where('transactions_id', '=', $trx_id);


        $query->select('transactionscomments.*', 'customers.legal_name', 'users.name', 'users.image_profile');

        $searchResults = $query->get();
        return $searchResults;
    }

}
