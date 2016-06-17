use coral_licensing_prod;

drop table coral_licensing_prod.XLink;

CREATE TABLE `XLink` (
  `LinkID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CoralName`     varchar(256) DEFAULT NULL,
  `SFXTarget`     varchar(256) DEFAULT NULL,
  `SFXPublicName` varchar(256) DEFAULT NULL,
  `OURTitle`      varchar(256) DEFAULT NULL,
  `OURLink`       varchar(256) DEFAULT NULL,
    PRIMARY KEY (`LinkID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;
