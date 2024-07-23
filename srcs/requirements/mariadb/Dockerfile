FROM alpine:3.19

RUN apk update && \
	apk upgrade

# COPY /conf/my.cnf /etc/my.cnf

COPY script.sh /script.sh
RUN chmod 755 /script.sh

RUN apk add mysql

# RUN /script.sh
# CMD ["mysqld_safe", "--datadir=/var/lib/mysql"]