#!/bin/bash

docker buildx build --platform=linux/amd64 . -t mhus/linphone-test:0.3-amd64

