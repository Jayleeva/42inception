# Waiting for mysql to start
sleep 10

# If not alredy done, doing the autoconf (name, user, pass, ... + creating 2 users)
if [ ! -f /var/www/html/wp-config.php ]; then
	wp config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 --path='/var/www/wordpress'

	wp core install --allow-root \
		--url=$domain_name \
		--title=$brand \
		--admin_user=$wordpress_admin \
		--admin_password=$wordpress_admin_password \
		--admin_email=$wordpress_admin_email
fi
