#!/bin/bash

if [ -n -d "/home/user/self" ]; then
  mkdir -p /home/user/self
fi
cd /home/user/self

if [ -n -d "mhus-docker" ]; then
  git clone https://github.com/mhus/mhus-docker.git
fi

for dir in */; do
  cd dir
  if [ -e .git ]; then
    git reset --hard HEAD
    git pull
  fi
  if [ -x deploy-selfupdate.sh ]; then
    ./deploy-selfupdate.sh
  fi
  cd ..
done
