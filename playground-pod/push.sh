#!/bin/bash

. env.sh

docker push mhus/playground-pod:${VERSION}-amd64
#docker push mhus/playground-pod:${VERSION}-arm64

#docker push mhus/playground-pod:arm64
docker push mhus/playground-pod:amd64
docker push mhus/playground-pod:latest
