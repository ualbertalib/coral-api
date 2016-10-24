use coral_api_prod;

DROP PROCEDURE IF EXISTS GetSFXTargets;
DELIMITER //
CREATE  PROCEDURE `GetSFXTargets`()
BEGIN

  SELECT coralName,
         SFXTag
    FROM XloadLink
   WHERE XloadLink.documentID is NOT NULL
     and XloadLink.OURLink != ""
     and SFXTag != "";

END //


DROP PROCEDURE IF EXISTS GetXLinks;
CREATE  PROCEDURE `GetXLinks`()
BEGIN

  SELECT linkID,
         documentID,
         coralName,
         SFXTag,
         SFXPublicName,
         OURTitle,
         OURLink
    FROM XloadLink;

END //

DROP PROCEDURE IF EXISTS GetDuplicateXLinks;
CREATE  PROCEDURE `GetDuplicateXLinks`()
BEGIN

  SELECT documentID,
         coralName,
         SFXTag,
         SFXPublicName,
         OURTitle,
         OURLink
   FROM XloadLink
  WHERE SFXTag in (SELECT SFXTag
                    FROM XloadLink
                   WHERE SFXTag != ""
                GROUP BY SFXTag
                  HAVING count(SFXTag) > 1)
  ORDER BY SFXTag;

END //

DROP PROCEDURE IF EXISTS GetMissingXLinks;
CREATE  PROCEDURE `GetMissingXLinks`()
BEGIN

  SELECT documentID,
         coralName,
         SFXTag,
         SFXPublicName,
         OURTitle,
         OURLink
    FROM XloadLink
   WHERE documentID is null;

END //

DROP PROCEDURE IF EXISTS NotInCoral;
CREATE  PROCEDURE `NotInCoral`()
BEGIN
        SELECT coralName,
               SFXTag,
               SFXPublicName,
               OURTitle,
               OURLink
          FROM XloadLink
         WHERE documentID is null;

END //

