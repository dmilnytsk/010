#!/bin/bash

sudo cp -n auto_update.sh /etc/cron.weekly
date=$(date +%Y.%m.%d)
upd=/var/log/"update-$date".log
sudo touch $upd
{ 
    sudo apt-get update;
    sudo apt-get upgrade -y;
    echo `date`": Weekly update successful";
} > $upd
sudo chmod +x '.'/auto_update.sh
