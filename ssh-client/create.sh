#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t ssh-client .
else
	docker build -t ssh-client .
fi