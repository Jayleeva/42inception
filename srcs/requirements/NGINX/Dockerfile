FROM debian:trixie

RUN mkdir -p /etc/nginx/ssl

# Getting updates or installing all dependencies
RUN apt-get update && apt-get -y install \
    nginx \
    openssl \
    vim

# Copying the .conf in local directory /etc/nginx/nginx.conf
COPY /conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Copying the .sh, then giving the right to launch it localy
COPY /tools/nginx_entrypoint.sh /tmp/certs.sh
RUN chmod +x /tmp/certs.sh

RUN ./tmp/certs.sh
# bash interdit, donc utiliser ENTRYPOINT pour lancer ngninx_entrypoint.sh? 
# if the entrypoint is a script, ensure it runs no program in background (e.g, 'nginx & bash').

CMD ["nginx", "-g", "daemon off;"]
