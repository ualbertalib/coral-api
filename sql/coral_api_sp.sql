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


DROP PROCEDURE IF EXISTS GetDuplicateTags;
CREATE  PROCEDURE `GetDuplicateTags`()
BEGIN

    SELECT Document.shortName, SFXTag.SFXTag from SFXTag, Link, Document
     WHERE
          Link.sfxID = SFXTag.sfxID and
          Document.documentID =Link.documentID and
          Link.sfxID in (select sfxID from Link group by  sfxID having count(1) > 1)
    ORDER BY FXTag.SFXTag;
END //


DROP PROCEDURE IF EXISTS coral_api_prod.GetRights;
CREATE  PROCEDURE `GetRights`(IN target varchar(256), IN targetType varchar(10))
BEGIN

  DECLARE v_eclassId, v_coursePackId, v_linkId, v_printId, v_documentId, v_sfxId INT;
  declare v_eclassTxt, v_coursePackTxt, v_linkTxt, v_printTxt  VARCHAR(512);
  DECLARE v_ourLink VARCHAR(256);

  select expressionTypeID INTO v_eclassId     from coral_licensing_prod.ExpressionType where shortName = 'Course Management Systems';
  select expressionTypeID INTO v_coursePackId from coral_licensing_prod.ExpressionType where shortName = 'Course Packs';
  select expressionTypeID INTO v_linkId       from coral_licensing_prod.ExpressionType where shortName = 'Linking';
  select expressionTypeID INTO v_printId      from coral_licensing_prod.ExpressionType where shortName = 'Classroom Print Copies';

  -- try to cross resrence  SFXTarget to Coral db document id

  select NULL into v_documentId;
  if targetType = "SFX" THEN
    select sfxID into v_sfxId from SFXTag where SFXTag = target;
    if v_sfxId is not NULL THEN
        select MAX(documentID) into v_documentId from Link where sfxID = v_sfxId;
    END IF;
  ELSE
    select documentID into v_documentId from coral_licensing_prod.Document where Document.shortName = target;
  END IF;

   IF v_documentId is not NULL THEN
    select MAX(coral_licensing_prod.Qualifier.shortName)  into v_eclassTxt
    from coral_licensing_prod.Qualifier, coral_licensing_prod.ExpressionQualifierProfile, coral_licensing_prod.Expression
    where coral_licensing_prod.Expression.documentID = v_documentId and coral_licensing_prod.Expression.expressionTypeID = v_eclassId
      and coral_licensing_prod.ExpressionQualifierProfile.expressionID = coral_licensing_prod.Expression.expressionID
      and coral_licensing_prod.ExpressionQualifierProfile.qualifierID = coral_licensing_prod.Qualifier.qualifierID;

    select MAX(coral_licensing_prod.Qualifier.shortName)  into v_coursePackTxt
    from coral_licensing_prod.Qualifier, coral_licensing_prod.ExpressionQualifierProfile, coral_licensing_prod.Expression
    where coral_licensing_prod.Expression.documentID = v_documentId and coral_licensing_prod.Expression.expressionTypeID = v_coursePackId
      and coral_licensing_prod.ExpressionQualifierProfile.expressionID = coral_licensing_prod.Expression.expressionID
      and coral_licensing_prod.ExpressionQualifierProfile.qualifierID = coral_licensing_prod.Qualifier.qualifierID;

    select MAX(coral_licensing_prod.Qualifier.shortName)  into v_linkTxt
    from coral_licensing_prod.Qualifier, coral_licensing_prod.ExpressionQualifierProfile, coral_licensing_prod.Expression
    where coral_licensing_prod.Expression.documentID = v_documentId and coral_licensing_prod.Expression.expressionTypeID = v_linkId
      and coral_licensing_prod.ExpressionQualifierProfile.expressionID = coral_licensing_prod.Expression.expressionID
      and coral_licensing_prod.ExpressionQualifierProfile.qualifierID = coral_licensing_prod.Qualifier.qualifierID;

    select MAX(coral_licensing_prod.Qualifier.shortName)  into v_printTxt
    from coral_licensing_prod.Qualifier, coral_licensing_prod.ExpressionQualifierProfile, coral_licensing_prod.Expression
    where coral_licensing_prod.Expression.documentID = v_documentId and coral_licensing_prod.Expression.expressionTypeID = v_printId
      and coral_licensing_prod.ExpressionQualifierProfile.expressionID = coral_licensing_prod.Expression.expressionID
      and coral_licensing_prod.ExpressionQualifierProfile.qualifierID = coral_licensing_prod.Qualifier.qualifierID;
    END IF;


  IF v_documentId is not NULL THEN
    select 1 as "recFound",
           (select IFNULL(v_eclassTxt, "") REGEXP '^<font color=green><b>Yes|^Permitted|^<font color=red><b>Yes')  as "eClass",
           (select IFNULL(v_coursePackTxt, "") REGEXP '^<font color=green><b>Yes|^Permitted|^<font color=red><b>Yes') as "CoursePack",
           (select IFNULL(v_linkTxt, "Permitted") REGEXP '^<font color=green><b>Yes|^Permitted|^<font color=red><b>Yes') as "Link",
           (select IFNULL(v_printTxt, "") REGEXP '^<font color=green><b>Yes|^Permitted|^<font color=red><b>Yes') as "Print";
  ELSE
    select 0 as "recFound", 0 as "eClass", 0 as "CoursePack", 0 as "Link", 0 as "Print";
  END IF;


END //
