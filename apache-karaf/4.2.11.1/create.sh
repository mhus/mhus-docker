#!/bin/bash

VERSION=4.2.11.1

if [  ! -f Dockerfile ]; then
  echo "not a docker configuration"
  return 1
fi

docker stop karaf
docker rm karaf
docker rmi mhus/apache-karaf:$VERSION

if [ "$1" = "clean" ]; then
	DOCKER_BUILDKIT=0 docker build --no-cache -t mhus/apache-karaf:$VERSION .
else
	DOCKER_BUILDKIT=0 docker build --progress plain -t mhus/apache-karaf:$VERSION .
fi

if [ "$1" == "test" ]; then
  docker run -it -v ~/.m2:/home/user/.m2 -p 15005:5005 -p 18181:8181 --name karaf mhus/apache-karaf:$VERSION debug
fi
if [ "$1" = "push" ]; then
    docker push "mhus/apache-karaf:$VERSION"
fi 
