#!/bin/bash

FILEBEAT_CONFIG=/filebeat.yml

. /root/.m2/${APP_NAME}_env.sh
cd /opt/karaf

while [ "x$START_WAIT" == "x1" ]; do
  echo "START_WAIT is set ... waiting"
  sleep 10
  . /root/.m2/${APP_NAME}_env.sh
done
if [ "x$START_BASH" == "x1" ]; then
  /bin/bash
  exit
fi
if [ "x$START_REINSTALL" == "x1" ]; then
  rm installdone.mark
fi
if [ "x$START_FILEBEAT" == "x1" ]; then
  /bin/filebeat -e -c $FILEBEAT_CONFIG run &
  sleep 1
fi

# install 
cd /opt/karaf
rm instances/instance.properties 

if [ ! -e installdone.mark ]; then
    rm -r data/cache/*
    rm data/log/*
    echo "Start karaf in background"
	./bin/start
	sleep 5
	while [ "$(grep -c Done data/log/karaf.log)" = "0" ]; do
	  echo "."
	  sleep 5
	done
    cat /deploy.go | ./bin/client
	sleep 2
	echo "Stop karaf"
	./bin/stop
	sleep 5
	while [ "$(grep -c Stopping\ JMX\ OSGi\ agent data/log/karaf.log)" = "0" ]; do
	  echo "."
	  sleep 5
	done
	touch installdone.mark
fi

# Start Karaf

./bin/karaf
