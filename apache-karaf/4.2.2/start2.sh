#!/bin/bash

if [ $APP_UID != $(cat /etc/passwd|grep user:|cut -d : -f 3) ]
then 
  echo "========================================="
  echo Need to update UID to $APP_UID
  echo "========================================="
  userdel user
  useradd -u $APP_UID -ms /start.sh user
  chown -R user:user /home/user
else 
  echo UID is $APP_UID;
fi

chown -R user:user /opt/karaf

su user
