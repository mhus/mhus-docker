#!/bin/bash

cd /filebeat
./filebeat -e -c /filebeat.yml $@
