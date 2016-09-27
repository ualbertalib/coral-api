

DROP PROCEDURE IF EXISTS coral_licensing_prod.GetRights;

DELIMITER //
CREATE  PROCEDURE `GetRights`(IN target varchar(256), IN targetType varchar(10))
BEGIN
  DECLARE v_eclassId, v_coursePackId, v_linkId, v_printId, v_documentId INT;
  declare v_eclassTxt, v_coursePackTxt, v_linkTxt, v_printTxt  VARCHAR(512);
  DECLARE v_ourLink VARCHAR(256);

  select expressionTypeID INTO v_eclassId from ExpressionType where shortName = 'Course Management Systems';
  select expressionTypeID INTO v_coursePackId from ExpressionType where shortName = 'Course Packs';
  select expressionTypeID INTO v_linkId from ExpressionType where shortName = 'Linking';
  select expressionTypeID INTO v_printId from ExpressionType where shortName = 'Classroom Print Copies';

  -- try to cross resrence  SFXTarget to Coral db document id

  if targetType = "SFX" THEN
    select distinct documentID into v_documentId from XloadLink where SFXTarget = target AND documentId is NOT NULL;
    select max(OURLink) into v_ourLink from XloadLink where SFXTarget = target AND documentId = v_documentId;
  ELSE
    select documentID into v_documentId from XloadLink where coralName = target;
    select OURLink into v_ourLink from XloadLink where coralName = target;
  END IF;

  select Qualifier.shortName  into v_eclassTxt from Qualifier, ExpressionQualifierProfile, Expression
       where Expression.documentID = v_documentId and Expression.expressionTypeID = v_eclassId
        and ExpressionQualifierProfile.expressionID = Expression.expressionID
        and ExpressionQualifierProfile.qualifierID = Qualifier.qualifierID;

    select Qualifier.shortName  into v_coursePackTxt from Qualifier, ExpressionQualifierProfile, Expression
       where Expression.documentID = v_documentId and Expression.expressionTypeID = v_coursePackId
        and ExpressionQualifierProfile.expressionID = Expression.expressionID
        and ExpressionQualifierProfile.qualifierID = Qualifier.qualifierID;

    select Qualifier.shortName  into v_linkTxt from Qualifier, ExpressionQualifierProfile, Expression
       where Expression.documentID = v_documentId and Expression.expressionTypeID = v_linkId
        and ExpressionQualifierProfile.expressionID = Expression.expressionID
        and ExpressionQualifierProfile.qualifierID = Qualifier.qualifierID;

     select Qualifier.shortName  into v_printTxt from Qualifier, ExpressionQualifierProfile, Expression
       where Expression.documentID = v_documentId and Expression.expressionTypeID = v_printId
        and ExpressionQualifierProfile.expressionID = Expression.expressionID
        and ExpressionQualifierProfile.qualifierID = Qualifier.qualifierID;


  IF v_documentId is not NULL THEN
    select 1 as "recFound",
           (select IFNULL(v_eclassTxt, "") REGEXP '^<font color=green><b>Yes|^Permitted|^<font color=red><b>Yes')  as "eClass",
           (select IFNULL(v_coursePackTxt, "") REGEXP '^<font color=green><b>Yes|^Permitted|^<font color=red><b>Yes') as "CoursePack",
           (select IFNULL(v_linkTxt, "Permitted") REGEXP '^<font color=green><b>Yes|^Permitted|^<font color=red><b>Yes') as "Link",
           (select IFNULL(v_printTxt, "") REGEXP '^<font color=green><b>Yes|^Permitted|^<font color=red><b>Yes') as "Print",
           v_ourLink as "OURLink";
  ELSE
    select 0 as "recFound", 0 as "eClass", 0 as "CoursePack", 0 as "Link", 0 as "Print", v_ourLink as "OURLink";
  END IF;


END //
