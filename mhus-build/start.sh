#!/bin/bash

if [ $APP_UID != $(cat /etc/passwd|grep user:|cut -d : -f 3) ]
then 
  echo "========================================="
  echo Need to update UID to $APP_UID
  echo "========================================="
  userdel user
  useradd -u $APP_UID -ms /bin/bash user
  chown -R user:user /home/user
else 
  echo UID is $APP_UID;
fi
id

export PATH=/home/user/bin:$PATH

#runuser user "git config --global credential.helper store"

alias ll='ls -l'

cd /home/user
chmod +x bin/*
exec runuser user $@
