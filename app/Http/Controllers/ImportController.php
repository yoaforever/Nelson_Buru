<?php

namespace App\Http\Controllers;

use App\Http\Requests;
use App\Http\Controllers\Controller;
//use Illuminate\Http\Request;
use Input;
use Request;
use Redirect;
use Session;
use File;
use Exception;
use Mail;
use App\Models\BillerActivationToken;
use App\Models\PayorActivationToken;
use App\Models\UserActivationToken;
use App\Models\Customer;
use App\Models\CustomerRelation;
use App\Models\User;
use App\Models\BankAccount;
use App\Models\Transaction;
use App\Models\Ftp;


class ImportController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        return view('welcome');
        exit;
    }

    public function transimport() {
        $files = Input::file($_FILES);
        $statusmessage = "";
        foreach ($files as $file) {
            $filename = time() . '-' . $file->getClientOriginalName();
            $path = public_path() . '/uploads/csv';
            $mfile = $file->move($path, $filename);
            $Transctions = $this->readCSV($path . '/' . $filename);
            $count = 0;
            //$statusmessage .= "Following Transactions in ". $file->getClientOriginalName() ." are failed to import ";
            foreach ($Transctions as $Trans) {
                if ($count > 0) {
                    try {
                        $newtrans = array_filter($Trans); //which will removes columns with empty values

                        if (!empty($newtrans)) {//if atleast one column has value
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
                                    $statusmessage .= $Trans[5] . ' - Duplicated, ';
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
                                    $answer = array('answer' => 'Success', 'failedrows' => "Updated  Txn Successfully");
                                    $json = json_encode($answer);
                                    echo $json;
                                    exit;
                                }
                            } else {//if Transaction Doesn't exists  
                                /* $sql_insert = "INSERT INTO transactions(`id`,`biz_area_id`, `recordtype`,`number`, `relatednumber`, `receiver`,`creator`, `transactions_types_id`, `departure_date`,`arrival_date`, `due_date`, `currency_id`,`amount`, `description`, `transactions_status_id`,`payorrefnumber`, `biller_id`, `payor_id`,`user_id`, `created_at`, `updated_at`,`active`, `disputed_amount`, `disputedrefnumber`) VALUES('$Trans[0]','$Trans[1]', '$Trans[2]', '$Trans[3]', '$Trans[4]', '$Trans[5]', '$Trans[6]', '$Trans[7]', '$Trans[8]', '$Trans[9]', '$Trans[10]', '$Trans[11]', '$Trans[12]', '$Trans[13]', '$Trans[14]', '$Trans[15]', '$Trans[16]', '$Trans[17]', '$Trans[18]', '$Trans[19]', '$Trans[20]', '$Trans[21]', '$Trans[22]', '$Trans[23]')";
                                  $result=\DB::connection()->getpdo()->exec($sql_insert); */

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
                            }
                        }
                    } catch (Exception $e) {
                        /* echo "<pre>";
                          print_r($Trans);
                          echo "</pre>"; */
                        $statusmessage .= $Trans[5] . ', ';
                        continue;
                    }
                }
                $count = $count + 1;
            }
        }

        if ($statusmessage != "")
            $answer = array('answer' => 'Error', 'failedrows' => substr($statusmessage, 0, -2));
        else
            $answer = array('answer' => 'Success', 'failedrows' => "Uploaded Successfully");

        $json = json_encode($answer);
        echo $json;
        exit;
    }

    public function payorimport() {
        $files = Input::file($_FILES);
        foreach ($files as $file) {
            $filename = time() . '-' . $file->getClientOriginalName();
            $path = public_path() . '/uploads/csv';
            $mfile = $file->move($path, $filename);
            $Payors = $this->readCSV($path . '/' . $filename);
            $count = 0;
            //$statusmessage .= "Following Payors in ". $file->getClientOriginalName() ." are failed to import ";

            foreach ($Payors as $Payor) {
                if ($count > 0) {
                    try {
                        $newpayor = array_filter($Payor); //which will removes columns with empty values
                        if (!empty($newpayor)) {//if atleast one column has value
                            if (empty($Payor[0]) || empty($Payor[1]) || empty($Payor[2])) {
                                $statusmessage .= '<li>Skipped row ' . ($count + 1) . ': Required fields (legal_name,email,phone) are missing.</li>';
                                continue;
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
                                    $statusmessage .='<li>Skipped row ' . ($count + 1) . ': - Data Duplicated</li>';
                                } else {
                                    $existspayor->phone = $Payor[2];
                                    $existspayor->tin = $Payor[3];
                                    $existspayor->dba = $Payor[4];
                                    $existspayor->fax = $Payor[5];

                                    $existspayor->save();
                                    $data = array('email' => $Payor[1], 'name' => $Payor[0]);

                                    Mail::send('emails.payorInvite', array('name' => $data['name'], 'email' => $data['email']), function($message) use ($data) {
                                        $message->to($data['email'], $data['name'])->subject('You have been invited to Join PayAnyBiz by' . $data['name']);
                                    });
                                }
                            } else {//if Biller doesn't exists
                                $customer = new Customer();

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
                                $payor_current = Customer::where('id', '=', $Payor[6]);


                                $PayorId = $customer->id;

                                /* @User Email - Generate token in payor_activation_token and send invitation to payor */
                                $activation_token = new PayorActivationToken;
                                $activation_token->payor_id = $PayorId;
                                $activation_token->token = md5(uniqid(date('mdYhis'), true));

                                $activation_token->save();

                                $activation_url = url('/PayAnyBiz/ActivationPayor', ['token' => $activation_token->token]);

                                $data = array('email' => $Payor[1], 'name' => $payor_current->legal_name);

                                Mail::send('emails.payorInvite', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
                                    $message->to($data['email'], $data['name'])->subject('You have been invited to Join PayAnyBiz by' . $data['name']);
                                });
                            }
                        }
                    } catch (Exception $e) {
                        /* echo "<pre>";
                          print_r($Payor);
                          echo "</pre>"; */
                        $statusmessage .= '<li>Skipped row ' . ($count + 1) . ': Invalid Data</li>';
                        continue;
                    }
                }

                $count = $count + 1;
            }
        }
        if ($statusmessage != "")
            $answer = array('answer' => 'Error', 'failedrows' => '<ul>' . $statusmessage . '</ul>');
        else
            $answer = array('answer' => 'Success', 'failedrows' => "Uploaded Successfully");

        $json = json_encode($answer);

        echo $json;

        exit;
    }

    public function billerimport() {
        $files = Input::file($_FILES);
        foreach ($files as $file) {
            $filename = time() . '-' . $file->getClientOriginalName();
            $path = public_path() . '/uploads/csv';
            $mfile = $file->move($path, $filename);
            $Billers = $this->readCSV($path . '/' . $filename);
            $count = 0;
            //$statusmessage .= "Following Billers in ". $file->getClientOriginalName() ." are failed to import ";

            foreach ($Billers as $Biller) {
                if ($count > 0) {
                    try {

                        $newbiller = array_filter($Biller); //which will removes columns with empty values
                        if (!empty($newbiller)) {//if atleast one column has value
                            if (empty($Biller[0]) || empty($Biller[1]) || empty($Biller[2]) || empty($Biller[3]) || empty($Biller[6]) || empty($Biller[7]) || empty($Biller[8]) || empty($Biller[9]) || empty($Biller[10])) {
                                $statusmessage .= '<li>Skipped row ' . ($count + 1) . ': Required fields (Company_Name,Email_Address,Phone_Number,TIN,Address,City,Zip_Code,State,Country) are missing.</li>';
                                continue;
                            }


                            $existsbiller = Customer::where('legal_name', '=', $Biller[0])
                                    ->where('email', '=', $Biller[1], 'OR')
                                    ->first();

                            if (sizeof($existsbiller) > 0) {//if Biller already exists
                                if ($existsbiller->phone == $Biller[2] &&
                                        $existsbiller->tin == $Biller[3] &&
                                        $existsbiller->dba == $Biller[4] &&
                                        $existsbiller->fax == $Biller[5] &&
                                        $existsbiller->address == $Biller[6] &&
                                        $existsbiller->city_id == $Biller[7] &&
                                        $existsbiller->zip_postal == $Biller[8] &&
                                        $existsbiller->state_id == $Biller[9] &&
                                        $existsbiller->country_id == $Biller[10]
                                ) {
                                    $statusmessage .= '<li>Skipped row ' . ($count + 1) . ': - Data Duplicated</li>';
                                } else {
                                    $existsbiller->phone = $Biller[2];
                                    $existsbiller->tin = $Biller[3];
                                    $existsbiller->dba = $Biller[4];
                                    $existsbiller->fax = $Biller[5];
                                    $existsbiller->address = $Biller[6];
                                    $existsbiller->city_id = $Biller[7];
                                    $existsbiller->zip_postal = $Biller[8];
                                    $existsbiller->state_id = $Biller[9];
                                    $existsbiller->country_id = $Biller[10];

                                    $existsbiller->save();
                                }
                            } else {
                                $customer = new Customer();

                                $customer->legal_name = $Biller[0];
                                $customer->email = $Biller[1];
                                $customer->phone = $Biller[2];
                                $customer->tin = $Biller[3];
                                $customer->dba = $Biller[4];
                                $customer->fax = $Biller[5];
                                $customer->address = $Biller[6];
                                $customer->city_id = $Biller[7];
                                $customer->zip_postal = $Biller[8];
                                $customer->state_id = $Biller[9];
                                $customer->country_id = $Biller[10];
                                $customer->type_customer = 1;

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
                                $payor_current = Customer::where('id', '=', $Biller[17]);

                                $BillerId = $customer->id;

                                /* $sql_insert = "INSERT INTO customers(`legal_name`,`email`,`phone`,`tin`,`dba`,`fax`) VALUES('$Biller[0]', '$Biller[1]', '$Biller[2]', '$Biller[3]', '$Biller[4]', '$Biller[5]')";
                                  $result=\DB::connection()->getpdo()->exec($sql_insert);

                                  $BillerId = \DB::getPdo()->lastInsertId(); */

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
                            }
                        }
                    } catch (Exception $e) {
                        /* echo "<pre>";
                          print_r($Payor);
                          echo "</pre>"; */
                        $statusmessage .= '<li>Skipped row ' . ($count + 1) . ' - Invalid Data</li>';
                        continue;
                    }
                }
                $count++;
            }
        }
        if ($statusmessage != "")
            $answer = array('answer' => 'Error', 'failedrows' => '<ul>' . $statusmessage . '</ul>');
        else
            $answer = array('answer' => 'Success', 'failedrows' => "Uploaded Successfully");

        $json = json_encode($answer);

        echo $json;

        exit;
    }

    public function userimport() {
        $files = Input::file($_FILES);

        foreach ($files as $file) {
            $filename = time() . '-' . $file->getClientOriginalName();
            $path = public_path() . '/uploads/csv';
            $mfile = $file->move($path, $filename);
            $Users = $this->readCSV($path . '/' . $filename);
            $count = 0;
            //$statusmessage .= "Following Users in ". $file->getClientOriginalName() ." are failed to import ";

            foreach ($Users as $User) {
                if ($count > 0) { //to avlid first row (header) in csv
                    try {
                        $newuser = array_filter($User); //which will removes columns with empty values

                        if (!empty($newuser)) {//if atleast one column has value
                            //check if users exists with the customer_id
                            $isuserexists = User::where('username', '=', $User[1])->first();

                            if (sizeof($isuserexists) > 0) { //if user already exists
                                //check if all the data is duplicated
                                if ($isuserexists->customers_id == $User[0] &&
                                        $isuserexists->email == $User[2] &&
                                        $isuserexists->lastname == $User[3] &&
                                        $isuserexists->name == $User[4] &&
                                        $isuserexists->role_id == $User[5]
                                ) {
                                    $statusmessage .= $User[1] . ' - Duplicated, ';
                                } else {
                                    //Update Existing user information
                                    $isuserexists->customers_id = $User[0];
                                    $isuserexists->email = $User[2];
                                    $isuserexists->lastname = $User[3];
                                    $isuserexists->name = $User[4];
                                    $isuserexists->role_id = $User[5];

                                    $isuserexists->save();
                                    $data = array('email' => $User[2], 'name' => $User[4]);

                                    Mail::send('emails.updatedUser', array('name' => $data['name'], 'email' => $data['email']), function($message) use ($data) {
                                        $message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
                                    });
                                }
                            } else {//if user doesn't exists
                                //Create New User
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

                                $activation_url = url('/PayAnyBiz/Activation', ['token' => $activation_token->token]);

                                $data = array('email' => $User[2], 'name' => $User[4]);

                                Mail::send('emails.activation', array('name' => $data['name'], 'email' => $data['email'], 'url' => $activation_url), function($message) use ($data) {
                                    $message->to($data['email'], $data['name'])->subject('Welcome to PayAnyBiz!');
                                });
                            }//if user doesn'texists
                        }
                    } catch (Exception $e) {
                        $statusmessage .= $User[1] . $e->getMessage() . ', ';
                        continue;
                    }
                }
                $count = $count + 1;
            }
        }

        if ($statusmessage != "")
            $answer = array('answer' => 'Error', 'failedrows' => substr($statusmessage, 0, -2));
        else
            $answer = array('answer' => 'Success', 'failedrows' => "Uploaded Successfully");

        $json = json_encode($answer);
        echo $json;
        exit;
    }

    public function readCSV($csvFile) {
        $file_handle = fopen($csvFile, 'r');

        while (!feof($file_handle)) {
            $line_of_text[] = fgetcsv($file_handle, 1024);
        }

        fclose($file_handle);

        return $line_of_text;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create() {
        
    }

    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store($request) {
        
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

    /*
     * A CronJob will run this function for every minute to check whether any customer schduels imports.
    * @author: Rajendra*/
    public function getcronsftp()
    {
      $ftp = new Ftp();
      $ftp->cronSchedule();
    }

}
