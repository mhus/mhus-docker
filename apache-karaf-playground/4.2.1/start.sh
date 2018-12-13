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
  cd /opt/filebeat
  /opt/filebeat/filebeat -e -c $FILEBEAT_CONFIG run &
  sleep 1
fi

# install 
cd /opt/karaf
rm instances/instance.properties 

if [ ! -e installdone.mark -a -e /deploy.gsh ]; then
    rm -r data/cache/*
    rm data/log/*
    echo "Start karaf in background"
	./bin/start
	sleep 5
	while [ "$(grep -c Done data/log/karaf.log)" = "0" ]; do
	  echo "."
	  sleep 5
	done
    cat /deploy.gsh | ./bin/client
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

./bin/karaf $@
