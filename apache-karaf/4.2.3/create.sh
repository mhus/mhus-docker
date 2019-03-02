#!/bin/bash

VERSION=4.2.3

if [  ! -f Dockerfile ]; then
  echo "not a docker configuration"
  return 1
fi

if [ "$1" = "clean" ]; then
	docker build --no-cache -t mhus/apache-karaf:$VERSION .
else
	docker build -t mhus/apache-karaf:$VERSION .
fi
