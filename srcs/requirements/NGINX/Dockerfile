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

# Copying the .sh, then giving the right to launch it localy, defining it as entrypoint
COPY /tools/nginx.sh /tmp/certs.sh
RUN chmod +x /tmp/certs.sh
ENTRYPOINT [ "./tmp/certs.sh" ]
# utiliser ENTRYPOINT pour lancer ngninx.sh, puis lancer nginx avec CMD
# if the entrypoint is a script, ensure it runs no program in background (e.g, 'nginx & bash').

CMD ["nginx", "-g", "daemon off;"]
