#!/bin/bash

if [  "x$REPO_INIT" == "x" ]
then
  rm /home/user/done/*
  export REPO_INIT=1
fi

