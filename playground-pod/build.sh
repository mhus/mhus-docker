#!/bin/bash

. env.sh

docker buildx build --platform=linux/amd64 . -t mhus/playground-pod:${VERSION}-amd64
docker tag mhus/playground-pod:${VERSION}-amd64 mhus/playground-pod:latest 
docker tag mhus/playground-pod:${VERSION}-amd64 mhus/playground-pod:amd64

#docker buildx build --platform=linux/arm64 . -t mhus/playground-pod:${VERSION}-arm64
#docker tag mhus/playground-pod:${VERSION}-arm64 mhus/playground-pod:arm64

