<?php
$I = new AcceptanceTester($scenario);
$I->wantTo('ensure that \'SFX tags linked to more then one Coral record report\'  works');
$I->amOnPage('report_duptags.php');
$I->see('SFX tags linked to more then one Coral record');
$I->see('SFX Tag');
$I->see('Coral Name');
$I->see('ABC_CLIO_HISTORY_REFERENCE_ONLINE_COMPLETE');
$I->dontSeeElement('.btn.editingSize', ['value' => 'Add Links']);
$I->dontSeeElement('.btn.editingSize', ['value' => 'Delete']);
?>
