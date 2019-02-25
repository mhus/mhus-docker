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
  echo UID is $APP_UID;
fi

export PATH=/home/user/build:$PATH

runuser user git config --global credential.helper store

alias ll='ls -l'

cd /home/user
chmod +x build/*
exec runuser user /bin/bash $@
