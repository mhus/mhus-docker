#!/bin/bash

if [ $(basename $(pwd)) != "ssl-proxy" ]
then
  echo "Not in base directory"
  exit 1
fi

if [ "$1" = "clean" ]; then
	docker build --no-cache -t ssl-proxy .
else
	docker build -t ssl-proxy .
fi	
