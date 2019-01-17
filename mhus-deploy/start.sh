#!/bin/bash

export PATH=/home/user/build:$PATH

git config --global credential.helper store

alias ll='ls -l'

cd /home/user
chmod +x build/*
/bin/bash
