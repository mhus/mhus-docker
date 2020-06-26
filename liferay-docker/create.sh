#!/bin/bash

docker stop hfo-liferay-template
docker rm hfo-liferay-template

docker build -t hfo-liferay-template:42.0 .

docker run -it --rm -h liferay-template --name hfo-liferay-template -v /var/run/docker.sock:/var/run/docker.sock:rw -v $HOME:/home hfo-liferay-template:42.0 $1
