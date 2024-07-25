#!/bin/sh

mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
mysqld_safe --datadir=/var/lib/mysql &

sleep 5

# service mysql start
mysqld -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysqld -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" && \
mysqld -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" && \
mysqld -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" && \
mysqld -e "FLUSH PRIVILEGES" && \
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown && \
exec mysqld_safe

# -e MYSQL_ROOT_PASSWORD=root \
# -e MYSQL_USER=youruser \
# -e MYSQL_PASSWORD=youruserpassword \
# -d mysql:latest