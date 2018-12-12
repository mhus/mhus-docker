#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t apache-karaf-playground .
else
	docker build -t apache-karaf-playground .
fi