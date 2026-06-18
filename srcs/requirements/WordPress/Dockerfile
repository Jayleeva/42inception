FROM debian:bullseye

# Getting updates or installing all dependencies
RUN apt-get update && apt-get -y install \
	wget \
	php7.3 \
	php-fpm \
	php-mysql \
	mariadb-client
	
# Modifying lines about port and env in the php conf file (utiliser le fichier www.conf du git a la place)
#RUN sed -i -e 's/listen =.*/listen = wordpress:9000/g' /etc/php/7.3/fpm/pool.d/www.conf
#	&& sed -i -e 's/;clear_env = no/clear_env = no/g' /etc/php/7.3/fpm/pool.d/www.conf

# Getting wordpress CLI, which will allow autoconf, allowing execution and moving it to local binaries
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	&& chmod +x wp-cli.phar
	&& mv wp-cli.phar /usr/local/bin/wp

# Getting wordpress with wget, decompressing it and deleting the tar; then giving root access
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
	&& cd /var/www
	&& tar -xzf wordpress-6.0-fr_FR.tar.gz
	&& rm wordpress-6.0-fr_FR.tar.gz
	&& chown -R root:root /var/www/wordpress

# Copying the .conf in the local directory /etc/php/7.3/fpm/pool.d/www.conf
COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copying the .sh, then giving the right to launch it localy, defining it as entrypoint (?)
COPY /tools/wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh
ENTRYPOINT ["/usr/local/bin/wordpress.sh"]

# Launching PHP FPM while ignoring deamonize from conf file (?)
CMD ["/usr/sbin/php-fpm7.4", "-F"]
