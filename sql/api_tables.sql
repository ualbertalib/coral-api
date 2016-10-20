-- check that DB exits
CREATE DATABASE IF NOT EXISTS coral_api_prod;

-- use DB
use coral_api_prod;

-- (re)create table SFXTag
drop table if exists coral_api_prod.SFXTag;

CREATE TABLE `SFXTag` ( `sfxID`        int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SFXTag`       varchar(256) DEFAULT NULL,
  PRIMARY KEY (`sfxID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- switch DB
use coral_api_prod;

-- (re)create table Link
drop table if exists coral_api_prod.Link;

CREATE TABLE `Link` (
  `LinkID`        int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentID`    int(10) unsigned  NULL,
  `sfxID`         int(10) unsigned  NULL,
    PRIMARY KEY (`LinkID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

CREATE UNIQUE INDEX sfx_coral_link ON Link (documentID, sfxID);
-- this index is not required,
-- it will cause ajax crud to hung on saving duplicate record
-- duplicate records will be displayed in red
-- CREATE UNIQUE INDEX sfx_link ON Link (sfxID);

-- switch DB
use coral_api_prod;

-- (re) create Document view
drop view if exists coral_api_prod.Document;

create VIEW Document AS
  SELECT documentID,
         shortName
  from coral_licensing_prod.Document;

-- switch DB
use coral_api_prod;

drop table if exists coral_api_prod.XloadLink;

CREATE TABLE `XloadLink` (
  `linkID`        int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentID`    int(10) unsigned  NULL,
  `coralName`     varchar(256) DEFAULT NULL,
  `sfxID`         int(10) unsigned  NULL,
  `SFXTag`        varchar(256) DEFAULT NULL,
  `SFXPublicName` varchar(256) DEFAULT NULL,
  `OURTitle`      varchar(256) DEFAULT NULL,
  `OURLink`       varchar(256) DEFAULT NULL,
  `comments`      varchar(256) DEFAULT  NULL,
   PRIMARY KEY (`linkID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;




