FROM php:5.4-apache

ADD . /var/www/html

WORKDIR /var/www/html

RUN chown -R www-data:www-data *

RUN find ./ -type d -exec chmod 2755 {} \;

RUN find ./ -type f -exec chmod 0644 {} \;

ECHO "ServerName localhost"

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
