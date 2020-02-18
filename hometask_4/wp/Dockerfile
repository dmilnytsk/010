FROM ubuntu:18.04

MAINTAINER dmytro ilnytskyy <nilnytskiy7@gmail.com>

ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get -y update
RUN apt-get -qq -y install curl
RUN apt-get install apache2 apache2-utils -y  
RUN /etc/init.d/apache2 start
RUN apt-get install php7.2 php7.2-mysql libapache2-mod-php7.2 php7.2-cli php7.2-cgi php7.2-gd -y
RUN curl -O https://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz
RUN rm /var/www/html/index.*
RUN cp -R /wordpress/* /var/www/html/
RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/
RUN a2enmod rewrite
RUN /etc/init.d/apache2 restart
RUN touch /var/www/html/.htaccess
RUN chown :www-data /var/www/html/.htaccess
RUN chmod 664 /var/www/html/.htaccess
RUN /etc/init.d/apache2 restart

CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]
EXPOSE 80
