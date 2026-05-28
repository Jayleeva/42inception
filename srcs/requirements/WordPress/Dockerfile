FROM debian:trixie

# Getting updates or installing all dependencies
RUN apt-get update && apt-get -y install \
	bash \
	curl \
	php \
	php-fpm \
	php-mysql \
	php-redis \
	# php-zip \
	# php-cgi \
	# php-pdo \
	# php-gd php-cli \
	# php-mbstring \
	redis \
	mariadb-client

#Create the folder to enable php start
RUN mkdir /run/php

# Installing wp_cli command and putting it in the right directory /usr/local/bin
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

# Copying the .conf in the html directory /etc/php/7.3/fpm/pool.d/www.conf (?)
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Copying the .sh, then giving the right to launch it localy, definying it as entrypoint (?)
COPY ./tools/wordpress_entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress_entrypoint.sh
ENTRYPOINT ["/usr/local/bin/wordpress_entrypoint.sh"]

# Going to the html directory
WORKDIR /var/www/html/

# Exposing the 9000 port
EXPOSE 9000

# Launching PHP FPM in foreground and ignoring deamonize from conf file (-F) (?)
CMD ["/usr/sbin/php-fpm7.3", "-F"]
