# Creates MySQL database tables for Securities Master Database (SMD)
# The current script creates an EOD (End-of-day) Equity Master Database
# An iterative approach will be taken towards structuring the SMD
# Columns that are essential in ensuring a row can be uniquely identified by
# a human reader are given the NOT NULL attribute. It should result in a table 
# such that any missing data in any row can be found by a human. 

DROP DATABASE IF EXISTS securities_master;
CREATE DATABASE securities_master;
USE securities_master;

###############################
# Equity Master Specific Tables
###############################

CREATE TABLE daily_prices(
# We could use the triple (vendor_id, ticker_id, date) as a primary key,
# but instead we create an additional id column for easier referencing.
	id		BIGINT 	 UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	vendor_id	SMALLINT UNSIGNED NOT NULL,
	ticker_id	BIGINT 	 UNSIGNED NOT NULL,

	date		DATE 	 NOT NULL,
	open		DECIMAL(19,4) NULL,
	high		DECIMAL(19,4) NULL,
	low		DECIMAL(19,4) NULL,
	close		DECIMAL(19,4) NULL,
	adj_close	DECIMAL(19,4) NULL,
	date_created	DATETIME NOT NULL,
	date_updated	DATETIME NOT NULL
	
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE tickers(
# The ticker symbol column is not used as the primary key as in reality it
# isn't always a true 1-1 relationship
	id		BIGINT 	 UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	exchange_id	SMALLINT UNSIGNED NULL,

	symbol		VARCHAR(8) NOT NULL,
	instrument	ENUM('stock','index') NULL,
	name		VARCHAR(255) NULL,
	sector		VARCHAR(255) NULL,
	date_created	DATETIME NOT NULL,
	date_updated	DATETIME NOT NULL

) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

###############################
# Security Master Tables
###############################

CREATE TABLE data_vendors(
# The vendor from which data is collected from
	id		SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

	name		VARCHAR(255) NOT NULL,
	website_url	VARCHAR(255) NULL,
	date_created	DATETIME NOT NULL,
	date_updated	DATETIME NOT NULL

) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE exchanges(
	id		SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

	name		VARCHAR(255) NOT NULL,
	abbrev		VARCHAR(20) NULL,
	currency	VARCHAR(20) NULL,
	hq_country	VARCHAR(255) NULL,	# head-quarters country
	time_diff	TIME NULL,		# time difference between timezone of exchange and GMT/BST
	date_created	DATETIME NOT NULL,
	date_updated	DATETIME NOT NULL,
	
	INDEX(name)

) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


# FOREIGN KEYS are added after the tables have been created so that the
# the foreign key exists when referencing it

ALTER TABLE daily_prices 
ADD FOREIGN KEY (vendor_id) REFERENCES data_vendors(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;

ALTER TABLE daily_prices 
ADD FOREIGN KEY (ticker_id) REFERENCES tickers(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;

ALTER TABLE tickers 
ADD FOREIGN KEY (exchange_id) REFERENCES exchanges(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
