#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t logstash .
else
	docker build -t logstash .
fi