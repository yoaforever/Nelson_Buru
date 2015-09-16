<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\User;
Use App\Models\Customer;
Use App\Models\Ftp;
use Mail;
use File;
use Input;
use DB;
use Response;
use Exception;
use Session;

class FtpController extends Controller {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
    public function index() {
        //$transaction_dispute = MailBox::all();
        //return $transaction_dispute;
    }
	
	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
    public function create() {
		
		
	}
	public function saveFtp()
	{
		$ftp = new Ftp();
		$ftpIsExists = Ftp::where('user_id', '=', Input::get('user_id'))->first();
		if(!empty($ftpIsExists)) {
			$ftpIsExists->user_id = Input::get('user_id');
			$ftpIsExists->customer_id = Input::get('customer_id');
			$ftpIsExists->ftp_host = Input::get('ftp_host');
			$ftpIsExists->ftp_username = Input::get('ftp_user');
			$ftpIsExists->ftp_password = Input::get('ftp_pass');
			$ftpIsExists->cron_time = Input::get('hours').':'.Input::get('minutes');
			$ftpIsExists->created_at = date('Y-m-d H:i:s');
			if($ftpIsExists->save())
			{
				return Response::json(['success' => true,'msg' => 'Updated successfully.'], 200);
			}
			return Response::json(['error' => true,'msg' => 'Error occured while updating.'], 200);
		}else {
			$ftp->user_id = Input::get('user_id');
			$ftpIsExists->customer_id = Input::get('customer_id');
			$ftp->ftp_host = Input::get('ftp_host');
			$ftp->ftp_username = Input::get('ftp_user');
			$ftp->ftp_password = Input::get('ftp_pass');
			$ftp->cron_time = Input::get('hours').':'.Input::get('minutes');
			$ftp->created_at = date('Y-m-d H:i:s');
			if($ftp->save())
			{
				return Response::json(['success' => true,'msg' => 'Updated successfully.'], 200);
			}
			return Response::json(['error' => true,'msg' => 'Error occured while updating.'], 200);
		}
	}
	public function getFtp($id)
	{
		$ftp = new Ftp();
		$ftpDetails = Ftp::where('user_id', '=', $id)->first();
		return $ftpDetails;
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
