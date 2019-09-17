FROM php:5.4-apache

ADD . /var/www/html

WORKDIR /var/www/html

RUN chown -R www-data:www-data *

RUN find ./ -type d -exec chmod 2755 {} \;

RUN find ./ -type f -exec chmod 0644 {} \;

RUN echo "ServerName localhost" >> /etc/apache2/conf-enabled/optional.conf
RUN echo "ServerTokens Prod" >> /etc/apache2/conf-enabled/optional.conf
RUN echo "ServerSignature Off" >> /etc/apache2/conf-enabled/optional.conf
RUN echo "TraceEnable Off" >> /etc/apache2/conf-enabled/optional.conf

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
