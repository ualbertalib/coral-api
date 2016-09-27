<?php
$I = new AcceptanceTester($scenario);
$I->wantTo('ensure that missed SFX tags report  works');
$I->amOnPage('report_missedtags.php');
$I->see('SFX tags not linked to any Coral record');
$I->see('SFX Tag');
$I->see('AGZINES_FREE');
$I->dontSeeElement('.btn.editingSize', ['value' => 'Add Links']);
$I->dontSeeElement('.btn.editingSize', ['value' => 'Delete']);
?>
