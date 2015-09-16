<?php namespace App\Http\Controllers;

use App\Http\Requests;
use App\Http\Controllers\Controller;
Use App\Models\TransactionBudgetDetails;
use Illuminate\Http\Request;
use Input;

class TransactionBudgetController extends Controller {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
		//to optain all Budget Details
        $trx_budget_details = TransactionBudgetDetails::all();
        return $trx_budget_details;
	}

	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
	public function create(Request $request)
	{
		$trx_budget = new TransactionBudgetDetails();
		
		$number 	= $request->number;
		$container  = $request->container;
		$amount 	= $request->amount;
		$trx_id     = $request->transactions_id;
		
		$trx_budget->transactions_id = $request->transactions_id;
		$trx_budget->number = $request->number;
		$trx_budget->container = $request->container;
		$trx_budget->amount = $request->amount;
		$trx_budget->created_at = date('Y-m-d H:i:s');
		$trx_budget->updated_at = date('Y-m-d H:i:s');
		$trx_budget->active = 1;
		$trx_budget->users_id = $request->user_id;
		$trx_budget->save();
		
		$transactions = $trx_budget::where('transactions_id', '=', $request->transactions_id)->get();
		
        return $transactions;
	}

	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		//
	}

	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		
		$trx_budget = new TransactionBudgetDetails();
		
		$transactions = $trx_budget::where('transactions_id', '=', $id)->get();
		
        return $transactions;
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
		$trx_budget = new TransactionBudgetDetails();
		
		$transactions = $trx_budget::where('id', '=', $id)->delete();
		
		$transactions = $trx_budget::where('transactions_id', '=', Input::get('transactions_id'))->get();
		
        return $transactions;
        
	}

}
