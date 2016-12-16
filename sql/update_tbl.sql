-- select count(1) from XloadLink;

-- select distinct OURTitle, OURLink from XloadLink;

-- insert into OUR (OURTitle, OURLink) select distinct OURTitle, OURLink from XloadLink;
-- select * from OUR;

-- insert into SFX (SFXTarget, SFXPublicName) select distinct SFXTarget, SFXPublicName from XloadLink;

-- update XloadLink, SFX set XloadLink.sfxID = SFX.sfxID where XloadLink.SFXTarget = SFX.SFXTarget and XloadLink.SFXPublicName = SFX.SFXPublicName; 
-- SELECT * FROM coral_licensing_prod.XloadLink where sfxID is null;

-- update XloadLink, OUR set XloadLink.ourID = OUR.ourID where XloadLink.OURLink = OUR.OURLink and XloadLink.OURTitle = OUR.OURTitle;-

-- update XloadLink, Document set XloadLink.documentID = Document.documentID where XloadLink.coralName = Document.shortName;

-- select coralName, SFXTarget, SFXPublicName, OURTitle, OURLink from XloadLink where documentID is  null

-- select * from Document where Document.shortName like 'JSTOR%'
-- insert into Link (documentID, sfxID, ourID) select documentID, sfxID, ourID from XloadLink where documentID is not null

use  coral_licensing_prod;

select distinct documentID from XloadLink where SFXTarget = 'AMERICAN_PHYTOPATHOLOGICAL_SOCIETY_CURRENT' AND documentId is NOT NULL;
select expressionTypeID from ExpressionType where shortName = 'Linking';
select expressionTypeID  from ExpressionType where shortName = 'Course Management Systems';
select expressionTypeID  from ExpressionType where shortName = 'Course Packs';
select expressionTypeID  from ExpressionType where shortName = 'Classroom Print Copies';

    select * from Qualifier, ExpressionQualifierProfile, Expression
       where Expression.documentID = 56 and Expression.expressionTypeID = 14
        and ExpressionQualifierProfile.expressionID = Expression.expressionID
        and ExpressionQualifierProfile.qualifierID = Qualifier.qualifierID;



-- SELECT `Link`.`linkID`,
--    `Link`.`documentID`,
--    `Link`.`sfxID`,
 --   `Link`.`ourID`
-- FROM `coral_licensing_prod`.`Link`;

-- select count(documentID), sfxID from Link group by sfxID having count(documentID) > 1
-- select * from XloadLink where sfxID = 10
-- call NotInCoral()


use coral_api_prod;
call GetRights("HIGHWIRE_PRESS_AMERICAN_DENTAL_EDUCATION_ASSOCIATION", "SFX")

-- select * from Expression where documentID = 26 and expressionTypeID in (13, 3, 18, 14);
call GetXLinks()
call GetDuplicateXLinks();

call GetMissingXLinks();

select * from XloadLink where ourID is null and OURLink != "";

select * from OURlicdata where LicdataID  not in (select distinct ourID from XloadLink where ourID is not null);
update OURlicdata set LinkID = (select max(linkID) from XloadLink where ourID = OURlicdata.LicdataID);
select * from OURlicdata where LinkID is null;
select * from XloadLink where ourID = 1130;

select distinct ourID from XloadLink order by 1;



 q

select * from XloadLink where SFXTarget = "Adam _Mathew";

select * from XloadLink where SFXTarget = "JSTOR_BUSINESS_III_COLLECTION";

select * from XloadLink where SFXTarget = "CRKN_SPRINGER_LINK_CURRENT"  AND documentId = 585;

select SFXTarget from XloadLink where SFXTarget != "" group by SFXTarget having count(SFXTarget) > 1

update XloadLink set documentID = (select documentID from Document where shortName = '1ABC-CLIO') where XloadLink.linkID = 10;

delete from OURlicdata;

select LicdataID from OURlicdata where URL = 'http://tal.scholarsportal.info/alberta/ABCCLIO_History_Reference'

                                              https://tal.scholarsportal.info/alberta/ABCCLIO_History_Reference

select "GHiood" REGEXP  "^Hi|^Good" as word;
select NULL as phrase;