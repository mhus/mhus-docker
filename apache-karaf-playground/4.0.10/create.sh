#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t apache-karaf-playground:4.0.10 .
else
	docker build -t apache-karaf-playground:4.0.10 .
fi