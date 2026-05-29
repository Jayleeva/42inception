FROM debian:trixie

# Getting updates or installing all dependencies
RUN apt-get update && apt-get -y install \
    mariadb-server

# Copying the .conf in local directory /etc/mysql/mariadb.conf.d/50-server.conf
COPY /conf/mariadb.conf	/etc/mysql/mariadb.conf.d/50-server.conf

RUN -it mariadb_entrypoint.sh