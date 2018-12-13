#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t log-logstash .
else
	docker build -t log-logstash .
fi