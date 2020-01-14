#!/bin/bash

if [ $APP_UID != $(cat /etc/passwd|grep user:|cut -d : -f 3) ]
then 
  echo "========================================="
  echo Need to update UID to $APP_UID
  echo "========================================="
  userdel user
  useradd -u $APP_UID -ms /docker/start.sh user
  chown -R user:user /home/user
else 
  echo Run with uid $APP_UID;
fi

chown -R user:user /opt/karaf
chown -R user:user /opt/filebeat/data

exec runuser user $@
