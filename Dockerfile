# apache-php5.4
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
 LABEL maintainer="Mailson Barbosa <mbsinfor@gmail.com>"

# TODO: Rename the builder environment variable to inform users about application you provide them
 ENV BUILDER_VERSION 2.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building apache-php5.4 apps" \
      io.k8s.display-name="apache-php5.4" \
      io.openshift.expose-services="80:http" \
      io.openshift.tags="builder,php,apache."
# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
RUN yum install -y epel-release 
RUN yum install -y httpd php php-soap php-xml php-curl php-pecl-zendopcache php-gd php-cli php-mbstring php-mcrypt php-ldap php-zip php-fileinfo php-mysql php-pgsql && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
COPY ./src /opt/app-root/src

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
#COPY ./s2i/bin/ /usr/libexec/s2i
# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R apache:apache /opt/app-root
RUN chmod 710 /run/httpd
RUN chown apache:apache /run/httpd
RUN chmod 700 /run/httpd/htcacheclean
RUN chown apache:apache /run/httpd/htcacheclean
RUN chown -R apache /var/log/httpd
RUN setcap cap_net_bind_service=+epi /usr/sbin/httpd
RUN echo "ServerName localhost" >> /etc/httpd/conf.d/optional.conf
RUN echo "ServerTokens Prod" >> /etc/httpd/conf.d/optional.conf
RUN echo "ServerSignature Off" >> /etc/httpd/conf.d/optional.conf
RUN echo "TraceEnable Off" >> /etc/httpd/conf.d/optional.conf
RUN sed -i 's/\/var\/www\/html/\/opt\/app-root\/src/g' /etc/httpd/conf/httpd.conf
RUN sed -i 's/logs\/error_log/\/dev\/stderr/g' /etc/httpd/conf/httpd.conf
RUN sed -i 's/logs\/access_log/\/dev\/stdout/g' /etc/httpd/conf/httpd.conf
RUN sed -i 's/Indexes//g' /etc/httpd/conf/httpd.conf
RUN rm -f /etc/httpd/conf.d/welcome.conf
# This default user is created in the openshift/base-centos7 image
USER apache

# TODO: Set the default port for applications built using this image
EXPOSE 80

# TODO: Set the default CMD for the image
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
