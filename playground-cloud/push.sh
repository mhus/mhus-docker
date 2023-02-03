#!/bin/bash

. env.sh

docker push mhus/playground-cloud:${VERSION}-amd64
#docker push mhus/playground-cloud:${VERSION}-arm64

#docker push mhus/playground-cloud:arm64
docker push mhus/playground-cloud:amd64
docker push mhus/playground-cloud:latest
