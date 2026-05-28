FROM debian:trixie

# Getting updates or installing all dependencies
RUN apt-get update && apt-get -y install \
    nginx openssl


RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \ 
    -keyout /etc/ssl/private/cyglardo.key \
    -out /etc/ssl/certs/cyglardo.crt \
    -subj="/C=MA/ST=khouribga/L=khouribga/O=1337 School/OU=cyglardo/CN=cyglardo.42.fr"

# Copying the .conf in the html directory /etc/nginx/sites-available/nginx.conf (?)
COPY ./conf/nginx.conf /etc/nginx/sites-available/nginx.conf

# Copying the .sh, then giving the right to launch it localy, definying it as entrypoint (?)
COPY ./tools/nginx_entrypoint.sh /tmp/certs.sh
RUN chmod +x /tmp/certs.sh
ENTRYPOINT ["/tmp/certs.sh"]
