#!/bin/bash

. env.sh

docker buildx build --platform=linux/amd64 . -t mhus/playground-cloud:${VERSION}-amd64
docker tag mhus/playground-cloud:${VERSION}-amd64 mhus/playground-cloud:latest 
docker tag mhus/playground-cloud:${VERSION}-amd64 mhus/playground-cloud:amd64

#docker buildx build --platform=linux/arm64 . -t mhus/playground-cloud:${VERSION}-arm64
#docker tag mhus/playground-cloud:${VERSION}-arm64 mhus/playground-cloud:arm64

