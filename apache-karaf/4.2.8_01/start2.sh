#!/bin/bash

if [ -z "$CONTAINER_ID"]; then
    export CONTAINER_ID=`cat /proc/self/cgroup|grep memory| cut -d / -f 3|cut -b 1-12`
    if [ "x$CONTAINER_ID" = "xkubepods" ]; then
        export CONTAINER_ID=`cat /proc/self/cgroup|grep memory| cut -d / -f 5|cut -d \- -f 1`
    fi
fi
echo Application: $APP_NAME
echo Container  : $CONTAINER_ID

if [ "x$RUNTIME_ENV" == "x" ]; then
  RUNTIME_ENV=/home/user/.m2/${APP_NAME}_${CONTAINER_ID}_env.sh
fi
if [ -e $RUNTIME_ENV ]; then
    . $RUNTIME_ENV
    while [ "x$START_WAIT" == "x1" ]; do
      echo "START_WAIT is set ... waiting"
      sleep 10
      . $RUNTIME_ENV
    done
fi
if [ "x$START_BASH" == "x1" ]; then
  /bin/bash
  exit
fi

# Hosts

if [ "x$SET_K8S_HOSTS" == "x1" -a "x$KUBERNETES_SERVICE_HOST" != "x" ]
then
  echo "" >> /etc/hosts
  echo "# kubernetes services" >> /etc/hosts
  for key in $(compgen -A variable)
  do
    if [[ $key == *_SERVICE_HOST ]]
    then
      ip=$(eval 'echo "${'"$key"'}"')
      host=$(echo ${key:0:-13} | awk '{print tolower($0)}')
      cnt=$(cat /etc/hosts| grep -c " $host ")
      if [ $cnt -eq 0 ]
      then
        echo "$ip     $host " >> /etc/hosts
      fi
    fi
  done
fi

# User

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
fi

# need to set every time (if exists and is shared with other container)
if [ -e  /opt/karaf/data/log ]
then
    chown user:user /opt/karaf
    chown user:user /opt/karaf/data
    chown user:user /opt/karaf/data/log
fi

exec runuser user $@
