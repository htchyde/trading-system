DROP USER 'tradingsystem'@'localhost';
CREATE USER 'tradingsystem'@'localhost' IDENTIFIED BY 'password';

GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
	ON securities_master.*
	TO 'tradingsystem'@'localhost';
