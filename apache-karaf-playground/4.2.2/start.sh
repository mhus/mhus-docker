#!/bin/bash

if [ "x$RUNTIME_ENV" == "x" ]; then
  RUNTIME_ENV=/root/.m2/${APP_NAME}_env.sh
fi
if [ "x$FILEBEAT_CONFIG" == "x" ]; then
  FILEBEAT_CONFIG=/filebeat/logstash.yml
fi

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
fi
if [ "x$START_FILEBEAT" == "x1" ]; then
    echo "-------------------------------------"
    echo "Start Filebeat"
    echo "-------------------------------------"
  cd /opt/filebeat
  /opt/filebeat/filebeat -e -c $FILEBEAT_CONFIG &
  sleep 1
fi

# install 
cd /opt/karaf
rm instances/instance.properties 

if [ ! -e installdone.mark ]; then
    /install.sh
fi

# Start Karaf

echo "-------------------------------------"
printenv
echo "-------------------------------------"
echo "Start Karaf"
echo "-------------------------------------"
./bin/karaf $@
echo "-------------------------------------"
echo "Finish"
echo "-------------------------------------"
