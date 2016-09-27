<?php
$I = new AcceptanceTester($scenario);
$I->wantTo('Ensure that edit Links page works');
$I->amOnPage('edit/editLinks.php');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_1');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_2');
$I->seeElement('.btn.editingSize', ['value' => 'Delete']);
$I->seeElement('.btn.editingSize', ['value' => 'Add Coral-SFX Link']);
$I->click('Add Coral-SFX Link');
$I->seeElement('#add_form_Link');
$I->submitForm('#add_form_Link', array('documentID' => '10', 'sfxID' => '700'), 'Add Coral-SFX Link');
$I->seeInDatabase('Link', array('documentID' => '10', 'sfxID' => '700'));