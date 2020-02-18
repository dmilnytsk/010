FROM ubuntu:18.04

MAINTAINER Dmytro Ilnytskyy <nilnytskiy7@gmail.com>

RUN apt-get update
RUN apt-get install mysql-server-5.7 -y

RUN /etc/init.d/mysql start
RUN    sed -i "s/.*bind-address.*/bind-address =      0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
RUN /etc/init.d/mysql restart

EXPOSE 3306

CMD ["mysqld_safe"]
