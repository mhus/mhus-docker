#!/bin/bash

cd /root/builder

file=/home/$1
if [ -f $file ]; then
  echo "Use home file $file"
  LIFERAY_DOCKER_RELEASE_FILE_URL=$file
else
  LIFERAY_DOCKER_RELEASE_FILE_URL=$1
fi
echo "URL: $LIFERAY_DOCKER_RELEASE_FILE_URL"
export LIFERAY_DOCKER_RELEASE_FILE_URL

shift

./build_image.sh $@

# bash
