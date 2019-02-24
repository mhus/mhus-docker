#!/bin/bash

cd /home/user

reset.sh

if [  -z $1 ]; then
  for i in $(ls deploy/); do echo $i; touch retry/$i; done
else
  if [  -e deploy/$1 ]; then
    touch retry/$1
  else
    echo "Unknown target $1"
  fi
fi
