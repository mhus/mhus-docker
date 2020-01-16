#!/bin/bash

export CONTAINER_ID=`cat /proc/self/cgroup|grep memory| cut -d / -f 3|cut -b 1-12`

echo Application: $APP_NAME
echo Container  : $CONTAINER_ID

if [ "x$RUNTIME_ENV" == "x" ]; then
  RUNTIME_ENV=~/.m2/${APP_NAME}_${CONTAINER_ID}_env.sh
fi
if [ -e $RUNTIME_ENV ]; then
    . $RUNTIME_ENV
    while [ "x$START_WAIT" == "x1" ]; do
      echo "START_WAIT is set ... waiting"
      sleep 10
      . $RUNTIME_ENV
    done
    if [ "x$START_BASH" == "x1" ]; then
      /bin/bash
      exit
    fi
fi

if [ 0 != $(id -u) ]
then
  echo "!!! Container is not running with root user"
  echo "!!! You need to add USER 0 to the end of your Dockerfile"
  echo "!!! Execution stopped!"
  exit
fi

if [ $APP_UID != $(cat /etc/passwd|grep user:|cut -d : -f 3) ]
then 
  echo ">>> Update user UID to $APP_UID"
  userdel user
  useradd -u $APP_UID -ms /docker/start.sh user
  UPDATE_OWNER=1
else
  echo User ID  : $APP_UID;
fi

if [ "x$UPDATE_OWNER" == "x1" ]
then
  echo ">>> Update owner of files"
  chown -R user:user /opt/karaf
  chown -R user:user /opt/filebeat/data
fi

exec runuser user $@
