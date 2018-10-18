#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t mhu-mvn-release .
else
	docker build -t mhu-mvn-release .
fi