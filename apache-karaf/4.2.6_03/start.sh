#!/bin/bash

export CONTAINER_ID=`cat /proc/self/cgroup|grep memory| cut -d / -f 3|cut -b 1-12`

if [ "x$RUNTIME_ENV" == "x" ]; then
  RUNTIME_ENV=~/.m2/${APP_NAME}_${CONTAINER_ID}_env.sh
fi
if [ "x$FILEBEAT_CONFIG" == "x" ]; then
  FILEBEAT_CONFIG=/docker/filebeat/logstash.yml
fi
if [ "x$CONFIG_PROFILE" == "x" ]; then
  CONFIG_PROFILE=default
fi
export CONFIG_PROFILE

cd /opt/karaf

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
if [ "x$START_REINSTALL" == "x1" ]; then
  rm installdone.mark
  rm environmentdone.mark
fi
if [ "x$START_FILEBEAT" == "x1" ]; then
    echo "-------------------------------------"
    echo "Start Filebeat"
    echo "-------------------------------------"
  cd /opt/filebeat
  /opt/filebeat/filebeat -e -c $FILEBEAT_CONFIG &
  sleep 1
fi

# prepare
cd /opt/karaf
rm instances/instance.properties 

# environment
if [ ! "x$PREVENT_ENVIRONMENT" == "x1" -a ! -e environmentdone.mark ]; then
    /docker/environment.sh
    if [  -e /docker/environment_custom.sh ]; then
      /docker/environment_custom.sh
    fi
fi
# install
if [ ! "x$PREVENT_INSTALL" == "x1" -a ! -e installdone.mark ]; then
    /docker/install.sh
    if [  -e /docker/install_custom.sh ]; then
      /docker/install_custom.sh
    fi
fi

# Start Karaf

echo "-------------------------------------"
printenv
echo "-------------------------------------"
echo "Start Karaf ($$) $@"
echo "-------------------------------------"
exec ./bin/karaf $@
echo "-------------------------------------"
echo "Finish"
echo "-------------------------------------"
