#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t ssh-server .
else
	docker build -t ssh-server .
fi