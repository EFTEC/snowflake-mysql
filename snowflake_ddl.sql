CREATE TABLE `sec_snowflake` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `stub` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stub` (`stub`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
-- insert the firsrt value
INSERT INTO `sec_snowflake` (`stub`) VALUES ('a');
-- you could also need this one if it fails to generate the function (deterministic error...)
SET GLOBAL log_bin_trust_function_creators = 1;
