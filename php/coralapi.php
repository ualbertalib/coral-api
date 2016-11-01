<?php
header('Content-Type: application/json');
// this file contains MySQL login info
include 'credentials.php';

// Include the database class
include("class.db.php");

$db_connection=$db_connection . 'dbname=coral_api_prod';
$db = new db($db_connection, $db_user, $db_passwd);
$db->setErrorCallbackFunction("echo");

// $results = $db->select("ExpressionType2");

$target = "ADAM_MATTHEW_THE_GRAND_TOUR";
$target_type = "SFX";

$bind = array(":target" => $target,
              ":target_type" => $target_type);

$results = $db->run("call GetRights(:target, :target_type)", $bind);

//print_r($results);
// print_r(array_slice($results[0], 1, 4));

echo json_encode(array_slice($results[0], 0, 5));

?>

