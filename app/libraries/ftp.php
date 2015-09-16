<?php
ini_set('display_errors', 1);
include('phpseclib.php');
$connection = ssh2_connect('50.16.196.174', 22);
if (ssh2_auth_password($connection, 'payanybiz', 'welcome9mw48')) {
  echo "Authentication Successful!\n";
} else {
  die('Authentication Failed...');
}
?>