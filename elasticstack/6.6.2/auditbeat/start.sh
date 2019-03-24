#!/bin/bash

cd /auditbeat
./auditbeat -e -c /auditbeat.yml $@
