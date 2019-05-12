#!/bin/bash

if [ ! -d "/home/user/self" ]; then
  mkdir -p /home/user/self
fi
cd /home/user/self

if [ ! -d "mhus-docker" ]; then
  git clone https://github.com/mhus/mhus-docker.git
fi

for dir in */; do
  echo "######################################################################"
  echo "Update $dir"
  echo "######################################################################"
  cd $dir
  if [ -e .git ]; then
    git reset --hard HEAD
    git pull
  fi
  if [ -x deploy-selfupdate.sh ]; then
    echo "Execute deploy-selfupdate.sh"
    ./deploy-selfupdate.sh
  fi
  cd ..
done
