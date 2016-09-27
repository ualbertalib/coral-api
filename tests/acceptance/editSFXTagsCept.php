<?php
$I = new AcceptanceTester($scenario);
$I->wantTo('Ensure that edit SFX tag page works');
$I->amOnPage('edit/editSFXTags.php');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_1');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_2');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_3');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_4');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_5');
$I->click('Add SFX Tag');
$I->seeElement('#add_form_SFXTag');
$I->submitForm('#add_form_SFXTag', array('SFXTag' => '0000 - my new tag'), 'Save SFX Tag');
$I->see('0000 - my new tag');
$I->seeInDatabase('SFXTag', array('SFXTag' => '0000 - my new tag'));

//$I->fillField('SFXTag', 'AAA - My New SFX Tag');
//$I->click('Save SFX Tag');

//$I->seeInFormFields('add_form_SFXTag', [
 //   'button' => 'Cancel'
//]);
