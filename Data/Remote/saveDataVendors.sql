USE securities_master;

INSERT INTO data_vendors(name, website_url, date_created, date_updated) 
	VALUES ('Yahoo', 'finance.yahoo.com', NOW(), NOW());

INSERT INTO data_vendors(name, website_url, date_created, date_updated)
	VALUES ('Google', 'finance.google.com', NOW(), NOW());
