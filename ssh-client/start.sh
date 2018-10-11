#!/bin/bash

while [ 1 = 1 ]
do
  echo "Connect $@"
  /usr/bin/ssh -o "ConnectTimeout 3" -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" $@
  sleep 1
done
