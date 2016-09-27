<?php
/**
 * Created by PhpStorm.
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
$tblSFXTag = new ajaxCRUD("SFX Tag",
    "SFXTag", "sfxID");


# don't show the primary key/foreign key in the table
$tblSFXTag->omitPrimaryKey();

# display headers as reasonable titles
$tblSFXTag->displayAs("SFXTag", "SFX Tag");
$tblSFXTag->validateDeleteWithFunction("canRowBeDeleted");

function canRowBeDeleted($id){
    $id = q1("SELECT LinkID from Link where sfxID = $id");
    if(strlen($id) > 0)
        return false;
    else
        return true;
}

# add the filter box (above the table)
$tblSFXTag->addAjaxFilterBox("SFXTag");

# do not allow to edit any fields
$tblSFXTag->setLimit(30);
$tblSFXTag->setTextareaHeight('SFXTag', 14);
$tblSFXTag->setTextboxWidth('SFXTag', 25);

# actually show to the table
$tblSFXTag->showTable();
?>
