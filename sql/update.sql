update XloadLink, SFXTag set XloadLink.sfxID = SFXTag.sfxID  where SFXTag.SFXTag = XloadLink.SFXTag;
update XloadLink, coral_licensing_prod.Document set XloadLink.documentID = coral_licensing_prod.Document.documentID where XloadLink.coralName = coral_licensing_prod.Document.shortName;



-- update comments
update XloadLink set comments = "";
delete from XloadLink where sfxTag = '';
delete from XloadLink where coralName = '';
update XloadLink set comments = "Coral Name not found in CoralDB" where documentID is null and coralName != '' and sfxID is not null;
update XloadLink set comments = "SFX Tag is invalid" where  sfxID is null and documentID is not null;
update XloadLink set comments = "SFX Tag is invalid and Coral Name not found in CoralDB" where  sfxID is null and documentID is null;

-- update Link table
delete from Link;
insert into Link (documentID, sfxID)
(select documentID, sfxID from XloadLink where comments = '');
