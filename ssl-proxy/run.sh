#!/bin/bash
cp /usr/src/docker-registry.conf /tmp/docker-registry.conf
xyz=$(sed "s/<remote_server>/${REMOTE_SERVER}/g" /tmp/docker-registry.conf)
echo "$xyz" > /etc/nginx/conf.d/docker-registry.conf
nginx -g 'daemon off;'
