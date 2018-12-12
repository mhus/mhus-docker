#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t filebeat .
else
	docker build -t filebeat .
fi