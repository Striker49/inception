#!/bin/sh

mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
mysqld_safe --datadir=/var/lib/mysql &

sleep 5

service mysql start
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" && \
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" && \
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" && \
mysql -e "FLUSH PRIVILEGES" && \
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown && \
exec mysqld_safe

# -e MYSQL_ROOT_PASSWORD=root \
# -e MYSQL_USER=youruser \
# -e MYSQL_PASSWORD=youruserpassword \
# -d mysql:latest