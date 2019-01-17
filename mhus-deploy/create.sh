#!/bin/bash

if [ ! -e Dockerfile ]
then
  echo "Not in build directory"
  exit 1
fi

if [ "$1" = "clean" ]; then
	docker build --no-cache -t mhus-deploy .
else
	docker build -t mhus-deploy .
fi	
