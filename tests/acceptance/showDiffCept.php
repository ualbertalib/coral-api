<?php
$I = new AcceptanceTester($scenario);
$I->wantTo('ensure that reconsoliation report (CORAL vs OUR rights) works');
$I->amOnPage('report_diff.php');
$I->see('Reconciliation Report Coral vs OUR');
$I->see('Coral Rights');
$I->see('OUR Rights');
$I->see('Adam Mathew Publications');
$I->seeElement('iframe');
$I->dontSeeElement('.btn.editingSize', ['value' => 'Add Links']);
$I->dontSeeElement('.btn.editingSize', ['value' => 'Delete']);
?>