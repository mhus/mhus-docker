#!/bin/bash

VERSION=2022.05
REPOSITORY=mhus/pihole
V=$VERSION

if [  ! -f Dockerfile ]; then
  echo "not a docker configuration"
  return 1
fi


if [ "$1" = "clean" ]; then
    shift
    docker rmi $REPOSITORY:$V
    docker build --no-cache -t $REPOSITORY:$V .
else
    docker build -t $REPOSITORY:$V .
fi

docker tag $REPOSITORY:$V $REPOSITORY:$VERSION
docker tag $REPOSITORY:$V $REPOSITORY:latest

if [ "$1" = "push" ]; then
    docker push "$REPOSITORY:$V"
    docker push "$REPOSITORY:$VERSION"
    docker push "$REPOSITORY:latest"
fi 
