FROM debian:trixie

RUN mkdir -p /etc/nginx/ssl

# Getting updates or installing all dependencies
RUN apt-get update && apt-get -y install \
    nginx \
    openssl \
    vim

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \ 
    -keyout /etc/nginx/ssl/private/inception.key \
    -out /etc/nginx/ssl/certs/inception.crt \
    -subj "/C=CH/ST=vaud/L=lausanne/O=1020/OU=42/CN=cyglardo.42.fr/UID=cyglardo"

# Copying the .conf in local directory /etc/nginx/nginx.conf
COPY /conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Copying the .sh, then giving the right to launch it localy, definying it as entrypoint (?)
COPY /tools/nginx_entrypoint.sh /tmp/certs.sh
RUN chmod +x /tmp/certs.sh
ENTRYPOINT ["/tmp/certs.sh"]

CMD [ "nginx", "-g", "daemon off;" ]
