DROP PROCEDURE IF EXISTS coral_licensing_prod.GetSFXTargets;

DELIMITER //
CREATE  PROCEDURE `GetSFXTargets`()
BEGIN

  select  coralName, SFXTarget from XloadLink WHERE XloadLink.documentID is NOT NULL and XloadLink.OURLink != "" and SFXTarget != "";

END //


DROP PROCEDURE IF EXISTS coral_licensing_prod.GetXLinks;

DELIMITER //
CREATE  PROCEDURE `GetXLinks`()
BEGIN

  select linkID, documentID, coralName, SFXTarget, SFXPublicName, OURTitle, OURLink from XloadLink;

END //

DROP PROCEDURE IF EXISTS coral_licensing_prod.GetDuplicateXLinks;

DELIMITER //
CREATE  PROCEDURE `GetDuplicateXLinks`()
BEGIN

  select documentID, coralName, SFXTarget, SFXPublicName, OURTitle, OURLink from XloadLink
  where SFXTarget in (select SFXTarget from XloadLink where SFXTarget != "" group by SFXTarget having count(SFXTarget) > 1)
  order by SFXTarget;

END //

DROP PROCEDURE IF EXISTS coral_licensing_prod.GetMissingXLinks;

DELIMITER //
CREATE  PROCEDURE `GetMissingXLinks`()
BEGIN

  select documentID, coralName, SFXTarget, SFXPublicName, OURTitle, OURLink from XloadLink
  where documentID is null;

END //

DROP PROCEDURE IF EXISTS coral_api_prod.GetDuplicateTags;

DELIMITER //
CREATE  PROCEDURE `GetDuplicateTags`()
BEGIN

    select Document.shortName, SFXTag.SFXTag
    FROM SFXTag, Link, Document
    WHERE Link.sfxID = SFXTag.sfxID and
          Document.documentID =Link.documentID and
          Link.sfxID in (select sfxID from Link group by  sfxID having count(1) > 1);

END //

DROP PROCEDURE IF EXISTS coral_api_prod.GetMissedTags;

DELIMITER //
CREATE  PROCEDURE `GetMissedTags`()
BEGIN

    select SFXTag
    FROM SFXTag
    WHERE sfxID not in (select sfxID from Link);

END //
