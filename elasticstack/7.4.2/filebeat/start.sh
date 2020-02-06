#!/bin/bash

if [ -z "$CONTAINER_ID"]; then
    export CONTAINER_ID=`cat /proc/self/cgroup|grep memory| cut -d / -f 3|cut -b 1-12`
    if [ "x$CONTAINER_ID" = "xkubepods" ]; then
        export CONTAINER_ID=`cat /proc/self/cgroup|grep memory| cut -d / -f 5|cut -d \- -f 1`
    fi
fi
echo Container  : $CONTAINER_ID

cd /filebeat
exec ./filebeat -e -c /filebeat.yml $@
