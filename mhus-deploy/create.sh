#!/bin/bash

VERSION=1.0.2

if [ ! -e Dockerfile ]
then
  echo "Not in build directory"
  exit 1
fi

if [ "$1" = "clean" ]; then
	docker build --no-cache -t mhus/mhus-deploy:$VERSION .
else
	docker build -t mhus/mhus-deploy:$VERSION .
fi	
