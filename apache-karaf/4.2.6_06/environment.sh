#!/bin/bash

if [  ! -z $VARS_FILE -a -e $VARS_FILE ]; then
  echo Load VARS from $VARS_FILE
  . $VARS_FILE
fi

IFS=$'\n' read -d '' -r -a folders < /docker/environment_folders.txt

if [ -e /docker/profiles/${CONFIG_PROFILE} ]; then
  echo "- - - - - - - - - - - - - - - - - -"
  echo "Copy profile ${CONFIG_PROFILE} to /opt/karaf"
  cp -r /docker/profiles/${CONFIG_PROFILE}/* /opt/karaf/
fi

for folder in "${folders[@]}"; do
#    echo $folder
    for file in $folder/*; do
        if [ -f $file ]; then
            echo "- - - - - - - - - - - - - - - - - -"
            echo Update $file
            /docker/substitute.py $file $file
        fi
    done
done
echo "- - - - - - - - - - - - - - - - - -"
touch environmentdone.mark
