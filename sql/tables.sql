use coral_licensing_prod;

drop table if exists coral_licensing_prod.XloadLink;

CREATE TABLE `XloadLink` (
  `linkID`        int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentID`    int(10) unsigned  NULL,
  `coralName`     varchar(256) DEFAULT NULL,
  `SFXTarget`     varchar(256) DEFAULT NULL,
  `SFXPublicName` varchar(256) DEFAULT NULL,
  `sfxID`         int(10) unsigned  NULL,
  `OURTitle`      varchar(256) DEFAULT NULL,
  `OURLink`       varchar(256) DEFAULT NULL,
  `ourID`         int(10) unsigned  NULL,
    PRIMARY KEY (`LinkID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

drop table if exists coral_licensing_prod.OUR;

CREATE TABLE `OUR` (
  `ourID`        int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OURTitle`      varchar(256) DEFAULT NULL,
  `OURLink`       varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ourID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

drop table if exists coral_licensing_prod.SFX;

CREATE TABLE `SFX` (
  `sfxID`        int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SFXTarget`     varchar(256) DEFAULT NULL,
  `SFXPublicName` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`sfxID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

drop table if exists coral_licensing_prod.Link;

CREATE TABLE `Link` (
  `linkID`        int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentID`    int(10) unsigned  NULL,
  `sfxID`         int(10) unsigned  NULL,
  `ourID`         int(10) unsigned  NULL,
    PRIMARY KEY (`LinkID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

