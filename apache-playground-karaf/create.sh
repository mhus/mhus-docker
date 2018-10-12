#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t apache-playground-karaf .
else
	docker build -t apache-playground-karaf .
fi