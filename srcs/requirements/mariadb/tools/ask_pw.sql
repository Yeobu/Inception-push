USE mysql;
UPDATE user SET plugin = "" WHERE user = "root";
UPDATE user SET password = PASSWORD("mysql42") WHERE user = "root";
FLUSH PRIVILEGES;
