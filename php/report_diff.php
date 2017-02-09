<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="report.css" type="text/css" />
    <link rel="stylesheet" href="error.css" type="text/css" />
    <title>Reconciliation Report Coral vs OUR </title>
</head>
<body>

<?php
/**
 * Created by PhpStorm.
 * User: astrilets
 * Date: 2016-06-29
 * Time: 11:04 AM
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
$db_connection=$db_connection . 'dbname=coral_api_prod';
$db = new db($db_connection, $db_user, $db_passwd);
$db->setErrorCallbackFunction("echo");

// retrieve all SFX targets and corresponding Coral names
$results = $db->run("call GetSFXTargets()");

// set up table header to display results
$headers = array("SFX target", "Coral Name", "Coral Rights", "OUR Rights");

// setup paginator
$pages = new Paginator;

$itemsPerPage = 20;
$startRow = 0;

$pages->items_total = count($results);
$pages->items_per_page = $itemsPerPage;

if(isset($_GET['page']))
    $startRow = ($_GET['page'] -1) * $itemsPerPage;

// create string to display CORAL rights in way similar to OUR rights
$coralRights = <<<RIGHTS
<table class="sfx-table">
    <tbody><tr>
        <td>
            <table class="entry">
                <tbody><tr>
                    <th class="case">eClass?</th>
                    <td class=":eClClass">:eClass</td>
                </tr>
                </tbody></table>
        </td>
        <td>
            <table class="entry">
                <tbody><tr>
                    <th class="case">Course Packs?</th>
                    <td class=":cpClass">:coursePack</td>
                </tr>
                </tbody></table>
        </td>
        <td>
            <table class="entry">
                <tbody><tr>
                    <th class="case">Link?</th>
                    <td class=":lnClass">:link</td>
                </tr>
                </tbody></table>
        </td>
        <td>
            <table class="entry">
                <tbody><tr>
                    <th class="case">Print?</th>
                    <td class=":prnClass">:print</td>
                </tr>
                </tbody></table>
        </td>
    </tr>
    </tbody>
</table>
RIGHTS;


// loop through each SFX target
$target_type = "SFX";
$data = array();
$showResults = array_slice($results, $startRow, $itemsPerPage);

foreach($showResults as $value){

    // retrieve rights for each SFX target
    $sfx_target = $value["SFXTag"];
    $coralName = $value["coralName"];

    $bind = array(":target" => $sfx_target,
        ":target_type" => $target_type);

    $rights = $db->run("call GetRights(:target, :target_type)", $bind);
    $rightsRec = $rights[0];

    // add data to the data array
    $eClass = ($rightsRec["eClass"] == '1') ? "yes" : "no";
    $eClassClass = ($rightsRec["eClass"] == '1') ? "usage Yes" : "usage No";

    $coursePack = ($rightsRec["CoursePack"] == '1') ? "yes" : "no";
    $coursePackClass = ($rightsRec["CoursePack"] == '1') ? "usage Yes" : "usage No";

    $link = ($rightsRec["Link"] == '1') ? "yes" : "no";
    $linkClass = ($rightsRec["Link"] == '1') ? "usage Yes" : "usage No";

    $print = ($rightsRec["Print"] == '1') ? "yes" : "no";
    $printClass = ($rightsRec["Print"] == '1') ? "usage Yes" : "usage No";

    $ourLink = $rightsRec["OURLink"];
    $vars = array(
        ":eClass" => $eClass,
        ":eClClass" => $eClassClass,
        ":coursePack" => $coursePack,
        ":cpClass" => $coursePackClass,
        ":link" => $link,
        ":lnClass" => $linkClass,
        ":print" => $print,
        ":prnClass" => $printClass
    );

    $statement = "select max(OURLink) as OURLink from XloadLink where SFXTag = '$sfx_target' AND documentId is not null";
    $res = $db->run($statement);
    $ourLink = $res[0]["OURLink"];

    // $newvars = strtr($coralRights, $vars);
    $data[] = array($sfx_target, $coralName, strtr($coralRights, $vars), $ourLink);

}



// show report data
echo "<h1 class='band'>Reconciliation Report Coral vs OUR</h1>";
$t = new Table(true, "tableID");
$t->setHeaderClass("headClass");
$t->setBodyClass("bodyClass");
$t->setFooterClass("footClass");
$t->setColumnsWidth(array("35%", "25%", "20%", "20%"));
$t->showTable($headers, $data);

//echo'<pre/>';print_r( $pages->getPaginateData($_GET['page'], count($data)) );
echo "<div class='band'>", $pages->displayHtmlPages($_GET['page'],count($results)), "</div>";

?>

</body>
</html>
