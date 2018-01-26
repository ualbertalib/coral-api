<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="report.css" type="text/css" />
    <link rel="stylesheet" href="errors.css" type="text/css" />
    <title>Reconciliation Report Coral vs OUR </title>
</head>
<body>

<?php


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
$db_connection=$db_connection . 'dbname=coral_licensing_prod';
$db = new db($db_connection, $db_user, $db_passwd);
$db->setErrorCallbackFunction("echo");

// retrieve all SFX targets and corresponding Coral names
$results = $db->run("SELECT l.licenseId, l.shortName, s.shortName AS `status`,d.documentId , d.shortName AS document
FROM License l, `Status` s, Document d
WHERE l.statusId = s.StatusId AND d.licenseID = l.licenseID
");

// set up table header to display results
$headers = array("License ID", "Name", "Status", "Expression");

// setup paginator
$pages = new Paginator;

$itemsPerPage = 20;
$startRow = 0;

$pages->items_total = count($results);
$pages->items_per_page = $itemsPerPage;

if(isset($_GET['page'])){
    $startRow = ($_GET['page'] -1) * $itemsPerPage;
}




// loop through each SFX target
$target_type = "SFX";
$data = array();
$showResults = array_slice($results, $startRow, $itemsPerPage);



foreach($showResults as $row){

    $bind = array(':licenseId'=>$row['licenseId'], ':documentId'=>$row['documentId']);

    $expressions = $db->run("SELECT et.shortName AS expressionType,  documentText
FROM Expression e INNER JOIN ExpressionType et ON (e.expressionTypeID = et.expressionTypeID),
Document d
WHERE d.licenseID = :licenseId
AND e.documentID = :documentId", $bind );

// create subTable for expressions data
    $subTable = "<table class=\"sfx-table\"><tbody>";
    foreach($expressions as $row1){
        $subTable.="<tr><td>{$row1['expressionType']}</td> <td>{$row1['documentText']}</td> </tr>";
    }
    $subTable.="</tbody></table>";


    // $newvars = strtr($coralRights, $vars);
    $data[] = array($row['licenseId'], $row['shortName'], $row['status'], $subTable);

}



// show report data
echo "<h1 class='band'>Expression Report</h1>";
$t = new Table(true, "tableID");
$t->setHeaderClass("headClass");
$t->setBodyClass("bodyClass");
$t->setFooterClass("footClass");
$t->setColumnsWidth(array("5%", "15%", "10%", "70%"));
$t->showTable($headers, $data);

//echo'<pre/>';print_r( $pages->getPaginateData($_GET['page'], count($data)) );
echo "<div class='band'>", $pages->displayHtmlPages($_GET['page'],count($results)), "</div>";

?>

</body>
</html>
