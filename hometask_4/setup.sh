#!/usr/bin/env bash

#DOCKER ENGINE INSTALLATION
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo docker -v
sudo newgrp docker
sudo usermod -a -G docker $USER
echo $USER "ALL=(ALL) NOPASSWD: /usr/bin/docker" >> /etc/sudoers.d/docker
sudo systemctl restart docker
sudo service docker restart

#IMAGE DOWNLOAD FROM DOCKER HUB
docker push dmilnytsk/wp1
docker push dmilnytsk/mysql1
#DOCKER CONTAINERS CREATE
docker run --name mysql01 -e MYSQL_ROOT_PASSWORD=Password1234 -d dmilnytsk/mysql1
docker run --name wp1 --link mysql01 -p 8080:80 -e WORDPRESS_DB_HOST=mysql01:3306 -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=Password1234 -e WORDPRESS_DB_NAME=wordpress -e WORDPRESS_TABLE_PREFIX=wp_ -d dmilnytsk/wp1