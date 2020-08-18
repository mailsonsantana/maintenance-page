FROM php:5.4-apache

LABEL description="Pagina de manutenção para serviços de governo"
LABEL version="1.0"
LABEL maintainer="https://github.com/mailsonsantana/maintenance-page"

ADD . /var/www/html

WORKDIR /var/www/html

RUN chown -R www-data:www-data *

RUN find /var/www/html -type d -exec chmod 2755 {} \;

RUN find /var/www/html -type f -exec chmod 0644 {} \;

RUN echo "ServerName localhost" >> /etc/apache2/conf-enabled/optional.conf
RUN echo "ServerTokens Prod" >> /etc/apache2/conf-enabled/optional.conf
RUN echo "ServerSignature Off" >> /etc/apache2/conf-enabled/optional.conf
RUN echo "TraceEnable Off" >> /etc/apache2/conf-enabled/optional.conf

EXPOSE 80

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
