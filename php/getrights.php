<?php
header('Content-Type: application/json');
// this file contains MySQL login info
include 'credentials.php';

// Include the database class
include("class.db.php");

$db_connection=$db_connection . 'dbname=coral_licensing_prod';
$db = new db($db_connection, $db_user, $db_passwd);
$db->setErrorCallbackFunction("echo");

// $results = $db->select("ExpressionType2");

$target=$_GET["tag"];
$target_type=$_GET["type"];

if(empty($target))
    die("tag not specified");

if( empty($target_type) )
    die("type not specified");

if($target_type != "SFX" && $target_type != "CORAL")
    die("type should be SFX or CORAL");

// $target = "ADAM_MATTHEW_THE_GRAND_TOUR";
// $target_type = "SFX";

$bind = array(":target" => $target,
              ":target_type" => $target_type);

$results = $db->run("call GetRights(:target, :target_type)", $bind);

//print_r($results);
// print_r(array_slice($results[0], 1, 4));

echo json_encode(array_slice($results[0], 0, 5));

?>

