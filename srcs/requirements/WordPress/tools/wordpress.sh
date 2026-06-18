#!/bin/sh

# Waiting for mysql to start
sleep 10

# If not alredy done, doing the autoconf (name, user, pass, ... + creating 2 users)
if [ ! -f /var/www/html/wp-config.php ]; then
	wp config create --allow-root \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost="mariadb:3306" \
		--path='/var/www/wordpress' \
		--force \

	echo "==== [WORDPRESS] config created. ===="

	wp core install --allow-root \
		--url=$DOMAIN_NAME \
		--title=$TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL

	echo "==== [WORDPRESS] core installed. ===="

    wp user create $WP_USER $WP_EMAIL \
        --role=author \
        --user_pass=$WP_PASSWORD --allow-root

	echo "==== [WORDPRESS] user created. ===="s
fi
