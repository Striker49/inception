#!/bin/sh

# Add MariaDB paths to PATH
export PATH="/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/libexec/mariadb:$PATH"

# Initialize MariaDB
mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql

# Start MariaDB server in the background
mysqld_safe --datadir=/var/lib/mysql &

# Wait for MariaDB to start
sleep 10

# Execute SQL commands
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Shutdown MariaDB
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Start MariaDB server in the foreground
exec mysqld_safe --datadir=/var/lib/mysql
