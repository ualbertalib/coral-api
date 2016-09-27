<?php
$I = new AcceptanceTester($scenario);
$I->wantTo('Ensure that front page index.html works');
$I->amOnPage('edit/index.html');
$I->seeInTitle('Coral API Add-on');
$I->seeLink('Edit SFX Tags', './editSFXTags.php');
$I->seeLink('Edit SFX Tags - Coral Name links', './editLinks.php');
$I->seeLink('Original Spreadsheet - view only', './showLinks.php');
$I->seeLink('Coral vs OUR Rights Reconciliation Report','../report_diff.php');
$I->seeLink('SFX Tag linked to more then one Coral Name - should be empty','../report_duptags.php');
$I->seeLink('SFX Tag not linked to any Coral Name','../report_missedtags.php'); 