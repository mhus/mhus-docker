#!/bin/bash

VERSION=7.4.2
REPOSITORY=mhus/log-logstash

if [  ! -f Dockerfile ]; then
  echo "not a docker configuration"
  return 1
fi

docker rmi $REPOSITORY:$VERSION

if [ "$1" = "clean" ]; then
    docker build --no-cache -t $REPOSITORY:$VERSION .
else
    docker build -t $REPOSITORY:$VERSION .
fi

if [ "$1" = "push" ]; then
    docker push "$REPOSITORY:$VERSION"
fi 
