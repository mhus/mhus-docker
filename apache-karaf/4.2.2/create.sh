#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t apache-karaf:4.2.2 .
else
	docker build -t apache-karaf:4.2.2 .
fi