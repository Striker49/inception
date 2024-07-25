FROM alpine:3.19

RUN apk update && apk upgrade && \
	apk add wget

RUN apk add php && \
	apk add php-fpm && \
	apk add php-mysqli && \
	apk add mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.6-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.6-fr_FR.tar.gz && rm wordpress-6.6-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress
COPY /conf/php.ini /etc/php82
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY /conf/auto_config.sh /auto_config.sh

ENTRYPOINT ["auto_config.sh"]
