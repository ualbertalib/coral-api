<?php
/**
 * Created by PhpStorm.
 * User: astrilets
 * Date: 2016-07-05
 * Time: 1:12 PM
 */

# db login info
$MYSQL_DB    = "coral_licensing_prod";
require_once('preheader.php');

# the code for the class
include ('ajaxCRUD.class.php');

# this one line of code is how you implement the class
$tblLink = new ajaxCRUD("Links",
    "XloadLink", "linkID");


# don't show the primary key in the table
$tblLink->omitPrimaryKey();
//$tblLink->omitField("documentID");
$tblLink->omitField("sfxID");
$tblLink->omitField("ourID");

# my db fields all have prefixes;
# display headers as reasonable titles
$tblLink->displayAs("coralName", "Coral Name");
$tblLink->displayAs("documentID", "Found in Coral");
$tblLink->displayAs("SFXTarget", "SFX Tag");
$tblLink->displayAs("SFXPublicName", "SFX Public Name");
$tblLink->displayAs("OURTitle", "OUR Title");
$tblLink->displayAs("OURLink", "OUR Link");

# add field modifying functions
$tblLink->formatFieldWithFunction('OURLink', 'formatAsCode');
function formatAsCode($data){
    return htmlspecialchars($data);
}

$tblLink->formatFieldWithFunction('documentID', 'foundInCoral');
function foundInCoral($data){
    return ($data != "") ? "Yes" : "<div style='color:red'>No</div>";
}
$tblLink->disallowEdit('documentID');

#after update of Coral Name try to find new value in coral DB.
$tblLink->onUpdateExecuteCallBackFunction("coralName", "updateDocId");

function updateDocId ($array)
{
    $pkLinkID = $array['linkID'];
    $coralName = $array['coralName'];
    $success = qr("update XloadLink set documentID = (select documentID from Document where shortName = \"$coralName\") where XloadLink.linkID = $pkLinkID");

}

#after inserting new row update its document Id based on coral name
$tblLink->onAddExecuteCallBackFunction("updateDocId");

#some fileds should not be added by the user
$tblLink->omitAddField("documentID");
$tblLink->omitAddField("sfxID");
$tblLink->omitAddField("ourID");

# add the filter box (above the table)
$tblLink->addAjaxFilterBoxAllFields();
$tblLink->turnOffAjaxEditing();
$tblLink->disallowDelete();
$tblLink->disallowAdd();

# actually show to the table
$tblLink->showTable();

