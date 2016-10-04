use coral_licensing_prod;

DROP PROCEDURE IF EXISTS coral_licensing_prod.GetSFXTargets;

DELIMITER //
CREATE  PROCEDURE `GetSFXTargets`()
BEGIN

  select  coralName, SFXTarget from XloadLink WHERE XloadLink.documentID is NOT NULL and XloadLink.OURLink != "" and SFXTarget != "";

END //


DROP PROCEDURE IF EXISTS coral_licensing_prod.GetXLinks;

CREATE  PROCEDURE `GetXLinks`()
BEGIN

  select linkID, documentID, coralName, SFXTarget, SFXPublicName, OURTitle, OURLink from XloadLink;

END //

DROP PROCEDURE IF EXISTS coral_licensing_prod.GetDuplicateXLinks;

CREATE  PROCEDURE `GetDuplicateXLinks`()
BEGIN

  select documentID, coralName, SFXTarget, SFXPublicName, OURTitle, OURLink from XloadLink
  where SFXTarget in (select SFXTarget from XloadLink where SFXTarget != "" group by SFXTarget having count(SFXTarget) > 1)
  order by SFXTarget;

END //

DROP PROCEDURE IF EXISTS coral_licensing_prod.GetMissingXLinks;

CREATE  PROCEDURE `GetMissingXLinks`()
BEGIN

  select documentID, coralName, SFXTarget, SFXPublicName, OURTitle, OURLink from XloadLink
  where documentID is null;

END //

