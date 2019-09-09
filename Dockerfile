FROM php:5.4-apache

ADD . /var/www/html

WORKDIR /var/www/html

RUN chown -R www-data:www-data *

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]