FROM debian:trixie

# Getting updates or installing all dependencies
RUN apt-get update && apt-get -y install \
    mariadb-server

# Copying the .conf in local directory /etc/mysql/mariadb.conf.d/50-server.conf
COPY /conf/mariadb.conf	/etc/mysql/mariadb.conf.d/50-server.conf

# Copying the .sh, then giving the right to launch it localy, defining it as entrypoint
#COPY /tools/mariadb.sh /tmp/mysql/?
#RUN chmod +x /tmp/mysql/?
#ENTRYPOINT [ "./tmp/mysql/?" ]

CMD [ "/tools/mariadb.sh" ]