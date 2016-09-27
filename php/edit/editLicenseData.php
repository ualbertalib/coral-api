<?php
/**
 * Created by PhpStorm.
 * User: astrilets
 * Date: 2016-07-08
 * Time: 4:21 PM
 */
# db login info
$MYSQL_DB    = "coral_licensing_prod";
require_once('preheader.php');

# the code for the class
include ('ajaxCRUD.class.php');

# this one line of code is how you implement the class
$tblLicense = new ajaxCRUD("License",
    "OURlicdata", "LicdataID");


# don't show the primary key/foreign key in the table
$tblLicense->omitPrimaryKey();

# display headers as reasonable titles
$tblLicense->displayAs("LinkID", "Found In Spreadsheet");
$tblLicense->displayAs("Active", "Active");
$tblLicense->displayAs("Title", "Title");
$tblLicense->displayAs("Vendor", "Vendor");
$tblLicense->displayAs("Consortium", "Consortium");
$tblLicense->displayAs("EReserves", "E-Reserves");
$tblLicense->displayAs("CoursePack", "Course Pack");
$tblLicense->displayAs("DurableURL", "Durable URL");
$tblLicense->displayAs("AlumniAccess", "Alumni Access");
$tblLicense->displayAs("PerpetualAccess", "Perpetual Access");
$tblLicense->displayAs("Password", "Password");
$tblLicense->displayAs("ILLPrint", "ILL Print");
$tblLicense->displayAs("ILLElectronic", "ILL Electronic");
$tblLicense->displayAs("ILLAriel", "ILL Ariel");
$tblLicense->displayAs("WalkIn", "Walk In");
$tblLicense->displayAs("URL", "URL");
$tblLicense->displayAs("TextMining", "Text Mining");
$tblLicense->displayAs("LocalLoading", "Local Loading");

$tblLicense->formatFieldWithFunction('LinkID', 'foundInLinks');
function foundInLinks($data){
    return ($data != "") ? "Yes" : "<div style='color:red'>No</div>";
}

# add the filter box (above the table)
$tblLicense->addAjaxFilterBox("Title");
$tblLicense->addAjaxFilterBox("Vendor");
$tblLicense->addAjaxFilterBox("Consortium");
$tblLicense->addAjaxFilterBox("URL");

# do not allow to edit any fields
$tblLicense->turnOffAjaxEditing();
$tblLicense->setLimit(30);
$tblLicense->disallowAdd();
$tblLicense->disallowDelete();

# actually show to the table
$tblLicense->showTable();
