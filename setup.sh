#!/usr/bin/env bash

# CHECK THE NECESSARY COMPONENTS FOR CONFLUENCE INSTALLATION
bin="atlassian-confluence-7.3.1-x64.bin"
if [ ! -f $bin ];
then
	echo "$bin FOUND"
else
	echo "$bin NOT FOUND. Downloading..."
    wget 'https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-7.3.1-x64.bin'
fi

driver_dir="/opt/atlassian/confluence7_3_1/confluence/WEB-INF/lib"
driver="mysql-connector-java-5.1.48.jar"
if [ ! -f $driver ];
then
	echo "$driver FOUND"
else
	echo "$driver NOT FOUND. Downloading..."
    wget 'https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.48/mysql-connector-java-5.1.48.jar'
fi

# MYSQL INSTALLATION
apt-get update
apt-get install mysql-server -y

# MYSQL CONFIGURATION
sudo systemctl start mysql.service

sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456'; flush privileges; create database CONFLUENCE character set utf8 COLLATE utf8_bin; 
grant all privileges ON *.* TO 'root'@'%' IDENTIFIED BY '123456' with grant option;"

sudo sed -i "s/.*bind-address.*/bind-address =      0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo echo transaction-isolation=READ-COMMITTED >> /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql.service

 # CONFLUENCE INSTALLATION
cd /vagrant
sudo mkdir -p $driver_dir
sudo cp $driver $driver_dir
chmod +x $bin
./$bin -q -varfile ./silent.varfile
cd /opt/atlassian/confluence7_3_1/bin
./start-confluence.sh

# CONFLUENCE CONFIGURATION
# YOU NEED TO MANUALLY CONFIGURE CONFLUENCE ON http://localhost:8080
