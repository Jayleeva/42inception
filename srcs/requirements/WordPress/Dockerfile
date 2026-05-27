FROM debian:

# Getting updates or installing all dependencies
RUN apt-get update && apt-get -y install \
	bash \
  curl \
	php \
  php-mysql \
  php-zip \
  php-fpm \
  php-redis \
	# php-cgi \
	# php-pdo \
	# php-gd php-cli \
	# php-mbstring \
  redis \
  mariadb-client


# Installing wp_cli command and putting it in the right directory /usr/local/bin
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

# Copying the script, then giving the right to launch it localy, definying it as entrypoint
COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh
ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]


# Going to the html directory
WORKDIR /var/www/html/

# Exposing the 9000 port
EXPOSE 9000
