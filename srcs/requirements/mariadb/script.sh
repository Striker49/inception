#!/bin/sh

# Start mariadb service
if ! rc-service mariadb status | grep -q started;
then
    rc-service mariadb start
fi
while ! rc-service mariadb status | grep -q started;
do
    echo "MariaDB is not running. Waiting..."
    sleep 1
done

# Check if database exists
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

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

else
    echo "Database $MYSQL_DATABASE already exists"
fi

# Stop mariadb service
rc-service mariadb stop

exec mysqld_safe --datadir=/var/lib/mysql