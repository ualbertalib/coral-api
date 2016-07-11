<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="report.css" type="text/css" />
    <link rel="stylesheet" href="errors.css" type="text/css" />
    <title>Cross link between Coral SFX and OUR </title>
</head>
<body>

<?php
function getURL($text)
{
    preg_match_all('!https?://\S+!', $text, $matches);
    return $matches[0];
}
?>

<?php
/**
 * Created by PhpStorm.
 * User: astrilets
 * Date: 2016-07-04
 * Time: 2:05 PM
 */
header('Content-Type: text/html');
// this file contains MySQL login info
require 'credentials.php';

// nice html table generator class
require_once 'Table.class.php';

// Include the database class
require_once("class.db.php");


// include paginator class
require_once('paginator.class.php');

// connect to DB
$db = new db($db_connection, $db_user, $db_passwd);
$db->setErrorCallbackFunction("echo");

// retrieve all SFX targets and corresponding Coral names
$results = $db->run("call GetMissingXLinks()");

// set up table header to display results
$headers = array("Coral Name", "SFX Tag", "OUR Rights");
$ourLink = <<<OUR
<a href=":ourLink" target="_new">OUR Rights Availabe Click to View </a>
OUR;

$data = array();

foreach($results as $value){
    $coralName = $value["coralName"];
    $sfxTag = $value["SFXTarget"];
    $foundId = $value["documentID"];
    $ourRights = $value["OURLink"];

    $vars = array(":ourLink" => getURL($ourRights)[0]);
    $l = ($ourRights == "") ? "" : strtr($ourLink, $vars);
    $data[] = array($coralName, $sfxTag, $l);



}

// setup paginator
$pages = new Paginator;

$itemsPerPage = 50;
$startRow = 0;

$pages->items_total = count($data);
$pages->items_per_page = $itemsPerPage;

if(isset($_GET['page']))
    $startRow = ($_GET['page'] -1) * $itemsPerPage;


// show report data
echo "<h1 class='band'>Coral Names not found in Coral database (from xlink spreadsheet)</h1>";
$t = new Table(true, "tableID");
$t->setHeaderClass("headClass");
$t->setBodyClass("bodyClass");
$t->setFooterClass("footClass");
$t->setColumnsWidth(array("40%",  "35%", "25%"));
$t->showTable($headers, $data, $startRow, $itemsPerPage);

//echo'<pre/>';print_r( $pages->getPaginateData($_GET['page'], count($data)) );
echo "<div class='band'>", $pages->displayHtmlPages($_GET['page'],count($data)), "</div>";

?>