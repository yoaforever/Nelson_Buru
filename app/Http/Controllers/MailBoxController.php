<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\User;
Use App\Models\Customer;
use Mail;
use Input;
use DB;
use Response;
use Exception;
use Session;

class MailBoxController extends Controller {

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
	public function webmail_login()
	{
		Session::put('webmail_username', Input::get('username'));
        Session::put('webmail_password', Input::get('password'));
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		try{

			$imap = imap_open('{imap.gmail.com:993/imap/ssl/novalidate-cert}INBOX', "$username","$password");
			if($imap)
			{
				return 1;
			}
		}catch (Exception $e) {
			return 0;
		}
	}
	
	function inbox()
	{
		
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		

		$imap = imap_open('{imap.gmail.com:993/imap/ssl/novalidate-cert}', "$username","$password") or die("can't connect: " . print_r(imap_errors()));

		
		if(!$imap)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		$numMessages = imap_num_msg($imap);
		
		for ($i = 1; $i <= $numMessages; $i++) {
		   $header = imap_header($imap, $i);
		   $mailStruct = imap_fetchstructure($imap, $header->Msgno);
		   $attachments = $this->getAttachments($imap, $header->Msgno, $mailStruct, "");	
		   $fromInfo[$i] = $header->from[0];
		   $replyInfo[$i] = $header->reply_to[0];
		   $details[$i] = array(
		        "fromAddr" => (isset($fromInfo[$i]->mailbox) && isset($fromInfo[$i]->host))
		            ? $fromInfo[$i]->mailbox . "@" . $fromInfo[$i]->host : "",
		        "fromName" => (isset($fromInfo[$i]->personal))
		            ? $fromInfo[$i]->personal : "",
		        "replyAddr" => (isset($replyInfo[$i]->mailbox) && isset($replyInfo[$i]->host))
		            ? $replyInfo[$i]->mailbox . "@" . $replyInfo[$i]->host : "",
		        "replyName" => (isset($replyTo[$i]->personal))
		            ? $replyto[$i]->personal : "",
		        "subject" => (isset($header->subject))
		            ? $header->subject : "",
		        "udate" => (isset($header->udate))
		            ? $header->udate : "",
				"unread" => (isset($header->Unseen))
					? $header->Unseen : "",
				"uid" => imap_uid($imap, $i),
				"msgno" => trim($header->Msgno),
				'attachments' => $attachments
			);
		}
		$mailDetails = array_reverse($details);
		
		return array('fromInfo' => $fromInfo, 'replayInfo' => $replyInfo, 'details' => $mailDetails);
	}
	
	function sentitems()
	{
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		

		$imap = imap_open('{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Sent Mail', "$username","$password") or die("can't connect: " . print_r(imap_errors()));

		
		if(!$imap)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		$fromInfo = [];
		$replyInfo = [];
		$details = [];
		$numMessages = imap_num_msg($imap);
		for ($i = 1; $i <= $numMessages; $i++) {
		  
		   $header = imap_header($imap, $i);
		   $mailStruct = imap_fetchstructure($imap, $header->Msgno);
		   $attachments = $this->getAttachments($imap, $header->Msgno, $mailStruct, "");	
		   $fromInfo[$i] = $header->from[0];
		   $replyInfo[$i] = $header->reply_to[0];
		   $details[$i] = array(
		        "fromAddr" => (isset($fromInfo[$i]->mailbox) && isset($fromInfo[$i]->host))
		            ? $fromInfo[$i]->mailbox . "@" . $fromInfo[$i]->host : "",
		        "fromName" => (isset($fromInfo[$i]->personal))
		            ? $fromInfo[$i]->personal : "",
		        "replyAddr" => (isset($replyInfo[$i]->mailbox) && isset($replyInfo[$i]->host))
		            ? $replyInfo[$i]->mailbox . "@" . $replyInfo[$i]->host : "",
		        "replyName" => (isset($replyTo[$i]->personal))
		            ? $replyto[$i]->personal : "",
		        "subject" => (isset($header->subject))
		            ? $header->subject : "",
		        "udate" => (isset($header->udate))
		            ? $header->udate : "",
				"unread" => (isset($header->Unseen))
					? $header->Unseen : "",
				"uid" => imap_uid($imap, $i),
				"msgno" => trim($header->Msgno),
				'attachments' => $attachments
			);
		}
		$mailDetails = array_reverse($details);
		return array('fromInfo' => $fromInfo, 'replayInfo' => $replyInfo, 'details' => $mailDetails);
	}
	function drafts()
	{
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		

		$imap = imap_open('{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Drafts', "$username","$password") or die("can't connect: " . print_r(imap_errors()));

		
		if(!$imap)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		$numMessages = imap_num_msg($imap);
		for ($i = 1; $i <= $numMessages; $i++) {
		   
		   $header = imap_header($imap, $i);
		   $mailStruct = imap_fetchstructure($imap, $header->Msgno);
		   $attachments = $this->getAttachments($imap, $header->Msgno, $mailStruct, "");	
		   $fromInfo[$i] = $header->from[0];
		   $replyInfo[$i] = $header->reply_to[0];
		   $details[$i] = array(
		        "fromAddr" => (isset($fromInfo[$i]->mailbox) && isset($fromInfo[$i]->host))
		            ? $fromInfo[$i]->mailbox . "@" . $fromInfo[$i]->host : "",
		        "fromName" => (isset($fromInfo[$i]->personal))
		            ? $fromInfo[$i]->personal : "",
		        "replyAddr" => (isset($replyInfo[$i]->mailbox) && isset($replyInfo[$i]->host))
		            ? $replyInfo[$i]->mailbox . "@" . $replyInfo[$i]->host : "",
		        "replyName" => (isset($replyTo[$i]->personal))
		            ? $replyto[$i]->personal : "",
		        "subject" => (isset($header->subject))
		            ? $header->subject : "",
		        "udate" => (isset($header->udate))
		            ? $header->udate : "",
				"unread" => (isset($header->Unseen))
					? $header->Unseen : "",
				"uid" => imap_uid($imap, $i),
				"msgno" => trim($header->Msgno),
				'attachments' => $attachments
			);
		}
		$mailDetails = array_reverse($details);
		return array('fromInfo' => $fromInfo, 'replayInfo' => $replyInfo, 'details' => $mailDetails);
	}
	function trash()
	{
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		

		$imap = imap_open('{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Trash', "$username","$password") or die("can't connect: " . print_r(imap_errors()));

		
		if(!$imap)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		$numMessages = imap_num_msg($imap);
		if(!empty($numMessages)) {
		for ($i = 1; $i <= $numMessages; $i++) {
		   $header = imap_header($imap, $i);
		   $fromInfo[$i] = $header->from[0];
		   $replyInfo[$i] = $header->reply_to[0];
		   $mailStruct = imap_fetchstructure($imap, $header->Msgno);
		   $attachments = $this->getAttachments($imap, $header->Msgno, $mailStruct, "");	
		   $details[$i] = array(
		        "fromAddr" => (isset($fromInfo[$i]->mailbox) && isset($fromInfo[$i]->host))
		            ? $fromInfo[$i]->mailbox . "@" . $fromInfo[$i]->host : "",
		        "fromName" => (isset($fromInfo[$i]->personal))
		            ? $fromInfo[$i]->personal : "",
		        "replyAddr" => (isset($replyInfo[$i]->mailbox) && isset($replyInfo[$i]->host))
		            ? $replyInfo[$i]->mailbox . "@" . $replyInfo[$i]->host : "",
		        "replyName" => (isset($replyTo[$i]->personal))
		            ? $replyto[$i]->personal : "",
		        "subject" => (isset($header->subject))
		            ? $header->subject : "",
		        "udate" => (isset($header->udate))
		            ? $header->udate : "",
				"unread" => (isset($header->Unseen))
					? $header->Unseen : "",
				"uid" => imap_uid($imap, $i),
				"msgno" => trim($header->Msgno),
				'attachments' => $attachments
			);
		}
		$mailDetails = array_reverse($details);
		return array('fromInfo' => $fromInfo, 'replayInfo' => $replyInfo, 'details' => $mailDetails);
		}
		return 0;
		
	}
	public function delete_mail($uid,$folder)
	{
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		if($folder == 'INBOX')
		{

			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}INBOX';
		}
		if($folder == 'Draft')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Drafts';
		}
		if($folder == 'Sent')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Sent Mail';
		}
		if($folder == 'Trash')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Trash';
		}
		$imap = imap_open($path, "$username","$password") or die("can't connect: " . print_r(imap_errors()));
		if(!$imap)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		imap_delete($imap, $uid, FT_UID);
		imap_expunge($imap);
		return 1;
	}
	public function mail_details($uid,$msgno,$folder)
	{
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		if($folder == 'INBOX')
		{

			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}INBOX';
		}
		if($folder == 'Draft')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Drafts';
		}
		if($folder == 'Sent')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Sent Mail';
		}
		if($folder == 'Trash')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Trash';

		}
		$imap = imap_open($path, "$username","$password") or die("can't connect: " . print_r(imap_errors()));
		
		if(!$imap)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		$numMessages = imap_num_msg($imap);
		$mailStruct = imap_fetchstructure($imap, $msgno);
		$attachments = $this->getAttachments($imap, $msgno, $mailStruct, "");	
		
		
		$header = imap_header($imap, $msgno);
		//count($header);exit;
		$fromInfo = $header->from[0];
		$replyInfo = $header->reply_to[0];
		$details = array(
			"fromAddr" => (isset($fromInfo->mailbox) && isset($fromInfo->host))
				? $fromInfo->mailbox . "@" . $fromInfo->host : "",
			"fromName" => (isset($fromInfo->personal))
				? $fromInfo->personal : "",
			"replyAddr" => (isset($replyInfo->mailbox) && isset($replyInfo->host))
				? $replyInfo->mailbox . "@" . $replyInfo->host : "",
			"replyName" => (isset($replyTo->personal))
				? $replyto->personal : "",
			"subject" => (isset($header->subject))
				? $header->subject : "",
			"udate" => (isset($header->udate))
				? $header->udate : "",
			"unread" => (isset($header->Unseen))
				? $header->Unseen : "",
			"msgno" => trim($header->Msgno)
		);
		
		$toDetails = [];
		$ccDetails = [];
		if(!empty($header->to)) : foreach($header->to as $toaddress) :
		$toDetails[] = $toaddress->mailbox . "@" . $toaddress->host;
		endforeach;endif;
		if(!empty($header->cc)) : foreach($header->cc as $ccaddress) :
		$ccDetails[] = $ccaddress->mailbox . "@" . $ccaddress->host;
		endforeach;endif;
		if(isset($header->subject))
		{
			$subject = $header->subject;
		}else
		{
			$subject = '';
		}
		return array('subject' => $subject,'body' => $this->getBody($uid, $imap), 'toDetails' => $toDetails, 'ccDetails' => $ccDetails, 'attachments' => $attachments,'details' => $details);
	}

	
	//Mail details drafts
	public function mail_details_drafts($uid,$msgno)
	{
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		
		$imap = imap_open('{a2plcpnl0081.prod.iad2.secureserver.net}Draft', "$username","$password") or die("can't connect: " . print_r(imap_errors()));
		
		if(!$imap)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		$numMessages = imap_num_msg($imap);
		$mailStruct = imap_fetchstructure($imap, $msgno);
		$attachments = $this->getAttachments($imap, $msgno, $mailStruct, "");
		
		$header = imap_header($imap, $msgno);
		//count($header);exit;
		$fromInfo = $header->from[0];
		$replyInfo = $header->reply_to[0];
		$details = array(
			"fromAddr" => (isset($fromInfo->mailbox) && isset($fromInfo->host))
				? $fromInfo->mailbox . "@" . $fromInfo->host : "",
			"fromName" => (isset($fromInfo->personal))
				? $fromInfo->personal : "",
			"replyAddr" => (isset($replyInfo->mailbox) && isset($replyInfo->host))
				? $replyInfo->mailbox . "@" . $replyInfo->host : "",
			"replyName" => (isset($replyTo->personal))
				? $replyto->personal : "",
			"subject" => (isset($header->subject))
				? $header->subject : "",
			"udate" => (isset($header->udate))
				? $header->udate : "",
			"unread" => (isset($header->Unseen))
				? $header->Unseen : "",
			"msgno" => trim($header->Msgno)
		);
		
		$toDetails = [];
		$ccDetails = [];
		if(!empty($header->to)) : foreach($header->to as $toaddress) :
		$toDetails[] = $toaddress->mailbox . "@" . $toaddress->host;
		endforeach;endif;
		if(!empty($header->cc)) : foreach($header->cc as $ccaddress) :
		$ccDetails[] = $ccaddress->mailbox . "@" . $ccaddress->host;
		endforeach;endif;
		
		return array('subject' => $header->subject,'body' => $this->getBody($uid, $imap), 'toDetails' => $toDetails, 'ccDetails' => $ccDetails, 'attachments' => $attachments);
	}
	
	
	
	public function getBody($uid, $imap) {
	    $body = $this->get_part($imap, $uid, "TEXT/HTML",false,false);
	   
		// if HTML body is empty, try getting text body
	    if ($body == "") {
	        $body = $this->get_part($imap, $uid, "TEXT/PLAIN");
	    }
		
	    return $body;
	}
 
	public function get_part($imap, $uid, $mimetype = 1, $structure = false, $partNumber = false) {
	    if (!$structure) {
	           $structure = imap_fetchstructure($imap, $uid, FT_UID);
	    }
	    if ($structure) {
	        if ($mimetype == $this->get_mime_type($structure)) {
	            if (!$partNumber) {
	                $partNumber = 1;
	            }
	            $text = imap_fetchbody($imap, $uid, $partNumber, FT_UID);
	            switch ($structure->encoding) {
	                case 3: return imap_base64($text);
	                case 4: return imap_qprint($text);
	                default: return $text;
	           }
	       }
	 
	        // multipart 
	        if ($structure->type == 1) {
	            foreach ($structure->parts as $index => $subStruct) {
	                $prefix = "";
	                if ($partNumber) {
	                    $prefix = $partNumber . ".";
	                }
	                $data = $this->get_part($imap, $uid, $mimetype, $subStruct, $prefix . ($index + 1));
	                if ($data) {
	                    return $data;
	                }
	            }
	        }
	    }
	    return false;
	}
	
	public function get_mime_type($structure) {
	    $primaryMimetype = array("TEXT", "MULTIPART", "MESSAGE", "APPLICATION", "AUDIO", "IMAGE", "VIDEO", "OTHER");
	 
	    if ($structure->subtype) {
	       return $primaryMimetype[(int)$structure->type] . "/" . $structure->subtype;
	    }
	    return "TEXT/PLAIN";
	}
	
	function getAttachments($imap, $mailNum, $part, $partNum) {
	    $attachments = array();
		
		if (isset($part->parts)) {
	        foreach ($part->parts as $key => $subpart) {
				$newPartNum = ($key+1);
	            $result = $this->getAttachments($imap, $mailNum, $subpart,
	                $newPartNum);
				
	            if (count($result) != 0) {
	                 array_push($attachments, $result);
	             }
			}
	    }
	    else if (isset($part->disposition)) {
			
	        if ($part->disposition == "ATTACHMENT" || $part->disposition = 'INLINE') {
	            $partStruct = imap_bodystruct($imap, $mailNum,$partNum);
				if(isset($partStruct->encoding)){
					$enc = $partStruct->encoding;
				}else
				{
					$enc = 0;
				}
				if(!empty($part->dparameters)) : foreach($part->dparameters as $key => $value) :
				if($value->attribute == 'FILENAME')
				{
					$attachmentDetails = array(
		                "name"    => $value->value,
		                "partNum" => $partNum,
		                "enc"     => $enc
		            );
					return $attachmentDetails;
				}
				endforeach;endif;
	            
	        }
	    }
	    return $attachments;
	}
	function downloadAttachment($msgNo,$msgId,$attachmentId,$folder)
	{
		$this->getdata($msgNo,$savedirpath = '/',$delete_emails=false,$msgId,$attachmentId,$folder);
	}
	function getdecodevalue($message,$coding) {
		switch($coding) {
			case 0:
			case 1:
//				$message = imap_8bit($message);
				$message = imap_base64($message);
				break;
			case 2:
				$message = imap_binary($message);
				break;
			case 3:
			case 5:
				$message = imap_base64($message);
				break;
			case 4:
				$message = imap_qprint($message);
				break;
		}
		return $message;
	}
	function getdata($msgNo,$savedirpath = '/',$delete_emails=false,$msgId,$attachmentId,$folder) {
		
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		
		$nbattach = 0;
		// make sure save path has trailing slash (/)
		$savedirpath = str_replace('\\', '/', $savedirpath);
		if (substr($savedirpath, strlen($savedirpath) - 1) != '/') {
			$savedirpath .= '/';
		}

		if($folder == 'INBOX')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}INBOX';
		}
		if($folder == 'Draft')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Drafts';
		}
		if($folder == 'Sent')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Sent Mail';
		}
		if($folder == 'Trash')
		{
			$path = '{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Trash';
		}
		$mbox = imap_open($path, "$username","$password") or die("can't connect: " . print_r(imap_errors()));
		
		if(!$mbox)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		
		$message = array();
		$message["attachment"]["type"][0] = "text";
		$message["attachment"]["type"][1] = "multipart";
		$message["attachment"]["type"][2] = "message";
		$message["attachment"]["type"][3] = "application";
		$message["attachment"]["type"][4] = "audio";
		$message["attachment"]["type"][5] = "image";
		$message["attachment"]["type"][6] = "video";
		$message["attachment"]["type"][7] = "other";
			$structure = imap_fetchstructure($mbox, $msgNo, FT_UID);
			if (!isset($structure->parts)) continue;

			$parts = $structure->parts;
			
			$fpos = 2;
			for($i = 1; $i <= count($parts); $i++) {
				$message["pid"][$i] = ($i);
				$part = $parts[$i];
				
					if(isset($part->disposition) && $part->disposition == "ATTACHMENT" || $part->disposition == "INLINE") {
							
							$message["type"][$i] = $message["attachment"]["type"][$part->type] . "/" . strtolower($part->subtype);
							$message["subtype"][$i] = strtolower($part->subtype);
							$ext = $part->subtype;
							$params = $part->dparameters;
							$filename = $part->dparameters[0]->value;
							$mege = imap_fetchbody($mbox,$msgId,$attachmentId);					
							$data = $this->getdecodevalue($mege,$part->type);
							try {
								header("Content-Description: File Transfer");
							    header("Content-Type: application/octet-stream");
							    header("Content-Disposition: attachment; filename=\"".$filename."\"");
							    header("Content-Transfer-Encoding: binary");
							    header("Expires: 0");
							    header("Cache-Control: must-revalidate");
							    header("Pragma: public");
								echo $data;
								$nbattach++;
								$fpos+=1;
							}catch (Exception $e) {
								return 0;
							}
						
					}
				
			}
			if ($delete_emails) {
				// imap_delete tags a message for deletion
				imap_delete($mbox,$jk+1);
			}
		
	}
	
	function inboxCount()
	{
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		

		$imap = imap_open('{imap.gmail.com:993/imap/ssl/novalidate-cert}INBOX', "$username","$password") or die("can't connect: " . print_r(imap_errors()));
		
		if(!$imap)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		$count = 0;
		$headers = imap_headers($imap);
		foreach ($headers as $mail) {
			$flags = substr($mail, 0, 4);
			$isunr = (strpos($flags, "U") !== false);
			if ($isunr)
			$count++;
		}
		return $count;
	}
	function draftsCount()
	{
		$username = Session::get('webmail_username');
		$password = Session::get('webmail_password');
		

		$imap = imap_open('{imap.gmail.com:993/imap/ssl}[Gmail]/Drafts', "$username","$password") or die("can't connect: " . print_r(imap_errors()));

		
		if(!$imap)
		{
			echo "<h1>FAIL!</h1>\n";
		}
		$count = 0;
		$headers = imap_headers($imap);
		foreach ($headers as $mail) {
			$count++;
		}
		return $count;
	}
	/**
	 *@desc : Inserting mailContent in messages table.
	 *@return Response.
	 */
	public function send_mail()
	{
		$receivers = Input::get('receiver');
		$mailcc = Input::get('cc');
		$mailbcc = Input::get('bcc');
		//Checking whether receivers are empty or not
		$toEmail = array();
		$ccEmail = array();
		$bccEmail = array();
		$toName = array();
		$ccName = array();
		$bccName = array();
		if(!empty($receivers))
		{
			foreach($receivers as $receiver)
			{
				$toEmail[] = $receiver['text'];
				//$toName[] = $receiver['legal_name'];
			}
		}
		if(!empty($mailcc))
		{
			foreach($mailcc as $cc_mail)
			{
				$ccEmail[] = $cc_mail['text'];
				//$ccName[] = $cc_mail['legal_name'];
			}
		}
		if(!empty($mailbcc))
		{
			foreach($mailbcc as $bcc_mail)
			{
				$bccEmail[] = $bcc_mail['text'];
				//$bccName[] = $bcc_mail['legal_name'];
			}
		}
		//$message ="ssssssssss";
		if(Input::get('mailContent')!=""){
			$content = Input::get('mailContent');
		}
		
		$ccustomer = Customer::where('id', Input::get('current_customer_id'))->get();
		$fromName = $ccustomer[0]->legal_name;
		$fromEmail = $ccustomer[0]->email;
		//['sattarpatan@gmail.com', 'abdulsattar.p@gmail.com','sattarpatan.php@gmail.com'];
		if(Input::get('subject') != ""){
			$subject = Input::get('subject');
		}else{
			$subject = 'Mail From Pay Any Biz';
		}
		$data = array('fromemail'=>$fromEmail, 'fromname'=>$fromName, 'subject' => $subject, 'toemail'=>$toEmail, 'ccemail'=>$ccEmail, 'bccemail'=>$bccEmail, 'content' => $content);
		//dd($data['message']);
		Mail::send('emails.sample', array('content'=>$data['content']), function($message) use ($data)
		{    
			$message->from($data['fromemail'], $data['fromname']);
			$message->to($data['toemail'])->subject($data['subject']);   
			$message->cc($data['ccemail']);
			$message->bcc($data['bccemail']);  
			//$message->to($toEmail)->subject($subject);
			// $message->to($toEmail)->subject($subject)->cc($ccEmail); 
			//$message->cc($ccEmail, $ccName);
			//$message->bcc($bccEmail, $bccName);	
		});
		if(Mail:: failures()){
			return 0;
		}else
		{
			$username = Session::get('webmail_username');
			$password = Session::get('webmail_password');
			$stream = imap_open('{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Sent Mail', "$username","$password") or die("can't connect: " . print_r(imap_errors()));
			$receivers =  implode(";",$toEmail);
			imap_append($stream, "{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Sent Mail", "From: $username $username\r\n"
			                    ."Full Name:ddd\r\n"
								. "To: $receivers\r\n"
							    . "Subject:" .$subject . "\r\n"
							   	. "MIME-Version: 1 \r\n"
								. "Content-Type: text/html;\r\n\tcharset=\"ISO-8859-1\"\r\n"
								. "Content-Transfer-Encoding: 8bit \r\n"
								. "\r\n\r\n"
			                  
			                   . "\r\n"
			                   . "$content\r\n"
			                   );
			imap_close($stream);
			return 1;
		}
	}
	public function replay()
	{
		$receivers = Input::get('receiver');
		$mailcc = Input::get('cc');
		$mailbcc = Input::get('bcc');
		//Checking whether receivers are empty or not
		$toEmail = array();
		$ccEmail = array();
		$bccEmail = array();
		$toName = array();
		$ccName = array();
		$bccName = array();
		if(!empty($receivers)) {
			foreach($receivers as $receiver) {
				$toEmail[] = $receiver['text'];
				//$toName[] = $receiver['legal_name'];
			}
		}
		if(!empty($mailcc)) {
			foreach($mailcc as $cc_mail) {
				$ccEmail[] = $cc_mail['text'];
				//$ccName[] = $cc_mail['legal_name'];
			}
		}
		if(!empty($mailbcc)) {
			foreach($mailbcc as $bcc_mail) {
				$bccEmail[] = $bcc_mail['text'];
				//$bccName[] = $bcc_mail['legal_name'];
			}
		}
		if(Input::get('mailContent')!=""){
			$content = Input::get('mailContent');
		}
		$ccustomer = Customer::where('id', Input::get('current_customer_id'))->get();
		$fromName = $ccustomer[0]->legal_name;
		$fromEmail = $ccustomer[0]->email;
		if(Input::get('subject') != ""){
			$subject = Input::get('subject');
		}else{
			$subject = 'Mail From Pay Any Biz';
		}
		$data = array('fromemail'=>$fromEmail, 'fromname'=>$fromName, 'subject' => $subject, 'toemail'=>$toEmail, 'ccemail'=>$ccEmail, 'bccemail'=>$bccEmail, 'content' => $content);
		//dd($data['message']);
		Mail::send('emails.sample', array('content'=> $data['content']), function($message) use ($data) {    
			$message->from($data['fromemail'], $data['fromname']);
			$message->to($data['toemail'])->subject($data['subject']);   
			$message->cc($data['ccemail']);
			$message->bcc($data['bccemail']);  
			//$message->to($toEmail)->subject($subject);
			// $message->to($toEmail)->subject($subject)->cc($ccEmail); 
			//$message->cc($ccEmail, $ccName);
			//$message->bcc($bccEmail, $bccName);	
		});
		if(Mail:: failures()){
			return 0;
		}else
		{
			$username = Session::get('webmail_username');
			$password = Session::get('webmail_password');
			$stream = imap_open('{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Sent Mail', "$username","$password") or die("can't connect: " . print_r(imap_errors()));
			$receivers =  implode(";",$toEmail);
			imap_append($stream, "{imap.gmail.com:993/imap/ssl/novalidate-cert}[Gmail]/Sent Mail", "From: $username $username\r\n"
			                    ."Full Name:ddd\r\n"
								. "To: $receivers\r\n"
							    . "Subject:" .$subject . "\r\n"
							   	. "MIME-Version: 1 \r\n"
								. "Content-Type: text/html;\r\n\tcharset=\"ISO-8859-1\"\r\n"
								. "Content-Transfer-Encoding: 8bit \r\n"
								. "\r\n\r\n"
			                  
			                   . "\r\n"
			                   . "$content\r\n"
			                   );
			imap_close($stream);
			return 1;
		}
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
