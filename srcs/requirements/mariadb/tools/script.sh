#!/bin/sh

# Start mariadb service and make sure it has started before going further
if ! rc-service mariadb status | grep -q started;
then
    rc-service mariadb start
fi
while ! rc-service mariadb status | grep -q started;
do
    echo "MariaDB is not running. Waiting..."
    sleep 1
done

# Check if database exists and create it if it doesn't
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
mysql_secure_installation <<EOF

Y
Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
EOF

# Setup initial database and permissions
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

else
    echo "Database $MYSQL_DATABASE already exists"
fi

# Stop mariadb service
rc-service mariadb stop

# Start Mariadb in safe mode
exec mysqld_safe --datadir=/var/lib/mysql