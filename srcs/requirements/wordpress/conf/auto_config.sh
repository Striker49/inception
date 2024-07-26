#!/bin/sh

sleep 10
if (!file_exists("/var/www/wordpress/wp-config.php"))
	wp config create ==allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 --path='/var/www/wordpress'
wp core install
wp user create