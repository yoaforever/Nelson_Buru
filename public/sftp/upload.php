<?php
	set_include_path(get_include_path() . PATH_SEPARATOR . './phpseclib');
	//echo set_include_path(get_include_path() . PATH_SEPARATOR);
	include('Net/SFTP.php');
	
	upload();
	
	function upload()
	{
		$local_directory = 'uploads/nachafiles/' . date('Y-m-d', strtotime("-1 days")) . '/';
		
		$remote_directory = '/';

		/* Add the correct FTP credentials below */

		$sftp = new Net_SFTP('50.16.196.174');

		if (!$sftp->login('payanybiz', 'welcome9mw48')) 
		{
		    exit('Login Failed');
		} 
		
		$files_to_upload = array();
		
		if ($handle = opendir($local_directory)) 
		{
		    /* This is the correct way to loop over the directory. */
		    while (false !== ($file = readdir($handle))) 
		    {
		        if ($file != "." && $file != "..") 
		        {
		            $files_to_upload[] = $file;
		        }
		    }
		    closedir($handle);
		}

		if(!empty($files_to_upload))
		{
		    /* Now upload all the files to the remote server */
		    foreach($files_to_upload as $file)
		    {
		          /* Upload the local file to the remote server put('remote file', 'local file');*/
		          $success = $sftp->put($remote_directory . $file, $local_directory . $file,NET_SFTP_LOCAL_FILE);
				  if($success)
				  {
						echo "<h3>Uploaded Successfully.</h3>";exit;
				  }
		    }
		}
	}
?>