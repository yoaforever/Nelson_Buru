<?php namespace App\Http\Controllers;

use App\Http\Requests;
use App\Http\Controllers\Controller;

//use Illuminate\Http\Request;
use App\Models\TrxExport;
use Request;



class TrxExports extends Controller {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
		
		
		
		//$sftp = new Net_SFTP('50.16.196.174');
		$trxexports = TrxExport::all();
		//foreach($trxexports as $trx) :
		//echo "<pre>";
		//print_r($trx);
		//endforeach;
		
		$date = date("Ymd", strtotime("-1 days"));
	
		$hours =  date('H');
		
		$minutes =  date('m');
		
		$seconds = date('i');
		
		if(is_dir('uploads/nachafiles/' . date('Y-m-d', strtotime("-1 days"))))
		{
			echo "<h3>File already created.</h3>";
			exit;
		}
		
		if(!mkdir('uploads/nachafiles/' . date('Y-m-d', strtotime("-1 days")), 0777))
		{
			die('Error while creating directory');
		}
		
		$filename = $date . $hours . $minutes . $seconds . '.csv';
		
		$filename = "uploads/nachafiles/" . date('Y-m-d', strtotime("-1 days")) . '/' . $filename;
	    
		$handle = fopen($filename, 'w+');
		chmod($filename, 0777);
		fputcsv($handle, array('CompanyName/ContactName', 'Address', 'Address2', 'City', 'State', 'PostalCode', 'Phone', 'EMail', 'Payee', 'Date', 'CheckNumber', 'Amount', 'RoutingNumber','AccountNumber', 'Notes', 'Memo'));
		foreach($trxexports as $row) {
			fputcsv($handle, array($row['Payor_Name'], $row['Payor_Address'],'', $row['Payor_City'],$row['Payor_State'],$row['Payor_Zip'],'', '', $row['Payee_is_PAB'], date('m/d/Y', strtotime($row['created_at'])), '', $row['Trx_Amount'], $row['Payor_Routing_Num'],$row['Payor_Account_Num'], '', ''));
		}
	    fclose($handle);
		
		echo "<h3>File created successfully..</h3>";
		exit;
		
		//dd($trxexports);
		//return view('trxexports.index', compact('trxexports'));
	}

	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
	public function create()
	{
		$trxexport = new TrxExport;
        
		$trxexport->Payor_Name    		= "sattar";
        $trxexport->Payor_Address      	= "10-1-425";
		$trxexport->Payor_City      	= "1";
		$trxexport->Payor_State      	= "2";
		$trxexport->Payee_is_PAB      	= "3";
		$trxexport->Trx_Amount      	= "4";
		$trxexport->Payor_Routing_Num   = "5";
		$trxexport->Payor_Account_Num   = "6";
		$trxexport->Payor_Zip      		= "7";
		$trxexport->Last_Updated      	= "8";
		
        $trxexport->save();
		
	}

	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store($request)
	{ 
	
	dd('sss');
	

		//$input = Request::all();
		
		//$trxexports = new TrxExport;
		$trxexports->Payor_Name = 'sattar';
		$trxexports->Payor_Address ='hyd';
		//$trxexports->save();
		
		
		
		
		TrxExport::create($trxexports);
		
		//return $trxexports;
		//dd($input);
		
		/*$article = new Article;
		$article->title = $input['title'];
		$article->body = $input['body'];*/
		
		
		//TrxExport::create($request->all());
	}

	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		//
		
		dd('show');
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
