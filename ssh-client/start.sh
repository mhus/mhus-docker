#!/bin/bash

while [ 1 = 1 ]
do
  echo "Connect $@"
  /usr/bin/ssh $@
  sleep 1
done
