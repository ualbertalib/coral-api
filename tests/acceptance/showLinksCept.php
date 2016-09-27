<?php
$I = new AcceptanceTester($scenario);
$I->wantTo('ensure that show links (original spreadsheet) page works');
$I->amOnPage('edit/showLinks.php');
$I->see('Found in Coral');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_1');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_2');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_3');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_4');
$I->see('ADAM_MATTHEW_DIGITAL_EIGHTEENTH_CENTURY_JOURNALS_5');
$I->see('Digital Eighteenth Century Journals 1');
$I->see('Digital Eighteenth Century Journals 2');
$I->see('Digital Eighteenth Century Journals 3');
$I->see('Digital Eighteenth Century Journals 4');
$I->see('Digital Eighteenth Century Journals 5');
$I->dontSeeElement('.btn.editingSize', ['value' => 'Add Links']);
$I->dontSeeElement('.btn.editingSize', ['value' => 'Delete']);