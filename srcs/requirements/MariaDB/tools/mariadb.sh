#!/bin/sh

# Creating database and user with priviledge
service mysql start;

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
echo "==== [MARIADB] Database created. ===="

mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
echo "==== [MARIADB] User created. ===="

mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
echo "==== [MARIADB] Privileges set. ===="

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
exec mysql_safe

echo "==== [MARIADB] Database ready. ===="