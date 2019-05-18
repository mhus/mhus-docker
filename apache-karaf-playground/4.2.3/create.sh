#!/bin/bash

VERSION=4.2.3

if [  ! -f Dockerfile ]; then
  echo "not a docker configuration"
  return 1
fi

docker rmi mhus/apache-karaf-playground:$VERSION

if [ "$1" = "clean" ]; then
	docker build --no-cache -t mhus/apache-karaf-playground:$VERSION .
else
	docker build -t mhus/apache-karaf-playground:$VERSION .
fi

if [ "$1" = "push" ]; then
    docker push "mhus/apache-karaf-playground:$VERSION"
fi 
