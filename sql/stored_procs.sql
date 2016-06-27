DROP PROCEDURE IF EXISTS coral_licensing_prod.NotInCoral;

DELIMITER //
CREATE  PROCEDURE `NotInCoral`()
BEGIN
    select coralName, SFXTarget, SFXPublicName, OURTitle, OURLink from XloadLink where documentID is null;

END //


DROP PROCEDURE IF EXISTS coral_licensing_prod.GetRights;

DELIMITER //
CREATE  PROCEDURE `GetRights`(IN target varchar(256), IN targetType varchar(10))
BEGIN
  DECLARE v_eclassId, v_coursePackId, v_linkId, v_printId, v_documentId INT;
  DECLARE v_ourLink VARCHAR(256);

  select expressionTypeID INTO v_eclassId from ExpressionType where shortName = 'Course Management Systems';
  select expressionTypeID INTO v_coursePackId from ExpressionType where shortName = 'Course Packs';
  select expressionTypeID INTO v_linkId from ExpressionType where shortName = 'Linking';
  select expressionTypeID INTO v_printId from ExpressionType where shortName = 'Classroom Print Copies';

  -- try to cross resrence  SFXTarget to Coral db document id

  if targetType = "SFX" THEN
    select documentID into v_documentId from XloadLink where SFXTarget = target;
    select OURLink into v_ourLink from XloadLink where SFXTarget = target;
  ELSE
    select documentID into v_documentId from XloadLink where coralName = target;
    select OURLink into v_ourLink from XloadLink where coralName = target;
  END IF;

  IF v_documentId is not NULL THEN
    select 1 as "recFound",
           EXISTS(select 1 from Expression where documentID = v_documentId and expressionTypeID = v_eclassId) as "eClass",
           EXISTS(select 1 from Expression where documentID = v_documentId and expressionTypeID = v_coursePackId) as "CoursePack",
           EXISTS(select 1 from Expression where documentID = v_documentId and expressionTypeID = v_linkId) as "Link",
           EXISTS(select 1 from Expression where documentID = v_documentId and expressionTypeID = v_printId) as "Print",
           v_ourLink as "OURLink";
  ELSE
    select 0 as "recFound", 0 as "eClass", 0 as "CoursePack", 0 as "Link", 0 as "Print", v_ourLink as "OURLink";
  END IF;


END //