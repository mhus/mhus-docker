#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t log-filebeat .
else
	docker build -t log-filebeat .
fi