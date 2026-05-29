#!/bin/sh

# Creating database and user with priviledge
service mysql start;
mysql -e "CREATE DATABASE IF DOES NOT EXIST \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF DOES NOT EXIST \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
exec mysqld_safe