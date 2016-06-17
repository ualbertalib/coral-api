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


-- SELECT `Link`.`linkID`,
--    `Link`.`documentID`,
--    `Link`.`sfxID`,
 --   `Link`.`ourID`
-- FROM `coral_licensing_prod`.`Link`;

-- select count(documentID), sfxID from Link group by sfxID having count(documentID) > 1
-- select * from XloadLink where sfxID = 10


