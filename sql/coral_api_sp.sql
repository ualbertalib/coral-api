use coral_api_prod;

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

CREATE  PROCEDURE `GetMissedTags`()
BEGIN

    select SFXTag
    FROM SFXTag
    WHERE sfxID not in (select sfxID from Link);

END //
