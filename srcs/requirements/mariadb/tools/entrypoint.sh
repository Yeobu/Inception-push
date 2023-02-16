#!/bin/sh


if  [ ! -d "/var/lib/mysql/$DB_NAME" ]
then
    service mysql start
	/usr/bin/mysql_install_db
	echo "Creating \"wordpress\" database with mysql_install_db\n"
    apt-get update
    apt-get install -y expect
    SECURE_MYSQL=$(expect -c "
    set timeout 10
    spawn mysql_secure_installation
    expect \"Enter current password for root (enter for none):\"
    send \"$ADMIN_PASSWORD\r\"
    expect \"Change the root password?\"
    send \"n\r\"
    expect \"Remove anonymous users?\"
    send \"y\r\"
    expect \"Disallow root login remotely?\"
    send \"n\r\"
    expect \"Remove test database and access to it?\"
    send \"y\r\"
    expect \"Reload privilege tables now?\"
    send \"y\r\"
    expect eof
        ")
    echo "$SECURE_MYSQL"
	echo "CREATE DATABASE IF NOT EXISTS $DB_NAME; GRANT ALL ON $DB_NAME.* TO '$ADMIN_USER'@'%' IDENTIFIED BY '$ADMIN_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root
	mysql -h localhost -u root < ask_pw.sql
    apt-get purge -y expect
    echo "\"$DB_NAME\" database created.\n"
else
    echo "Database already created\n"
fi
service mysql stop
exec mysqld_safe --bind-address=0.0.0.0 
