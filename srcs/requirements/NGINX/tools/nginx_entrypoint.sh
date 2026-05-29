#!/bin/sh

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \ 
-keyout /etc/nginx/ssl/private/inception.key \
-out /etc/nginx/ssl/certs/inception.crt \
-subj "/C=CH/ST=Vaud/L=Lausanne/O=42/OU='${MYSQL_USER}'/CN='${DOMAIN_NAME}'"

sed -i -e 's/data-root: /var/lib/docker/data-root: /home/'${MYSQL_USER}'/data/g' /etc/docker/daemon.json

#nginx -g "daemon off;" 
# faux?? lance le programme "en fond"? 