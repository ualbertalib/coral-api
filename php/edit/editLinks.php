<?php
/**
 * User: astrilets
 * Date: 2016-07-08
 * Time: 4:21 PM
 */

# db login info
$MYSQL_DB    = "coral_api_prod";
require_once('preheader.php');


# the code for the class
include ('ajaxCRUD.class.php');

# this one line of code is how you implement the class
$tblLink = new ajaxCRUD("Coral-SFX Link",
    "Link", "LinkID");

$tblLink->defineRelationship(sfxID, SFXTag, sfxID, sfxTag);
$tblLink->defineRelationship(documentID, Document, documentID, shortName);


# don't show the primary key/foreign key in the table
$tblLink->omitPrimaryKey();

# display headers as reasonable titles
$tblLink->displayAs("sfxID", "SFX Tag");
$tblLink->displayAs("documentID", "Coral Document");

$tblLink->addAjaxFilterBox("documentID", 10);
$tblLink->addAjaxFilterBox("sfxID", 10);
// $tblLink->onAddExecuteCallBackFunction("doMyLogicForAdding");

function doMyLogicForAdding($array)
{
    echo "<script type='text/javascript'>alert('added successfully!')</script>";
}

// $tblLink->addButton("Back to Main Screen", "./index.html");

# actually show to the table
$tblLink->showTable();
?>

