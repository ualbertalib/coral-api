use coral_licensing_prod;

DROP PROCEDURE IF EXISTS coral_licensing_prod.NotInCoral;

DELIMITER //
CREATE  PROCEDURE `NotInCoral`()
BEGIN
        select coralName, SFXTarget, SFXPublicName, OURTitle, OURLink from XloadLink where documentID is null;

END //

