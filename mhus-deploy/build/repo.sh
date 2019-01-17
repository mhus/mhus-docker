#!/bin/bash

name=$1
shift

url=$1
shift

if [  -e "/home/user/done/${name}" ]
then
    echo "--- Skip ${name} - already none"
    exit 0
fi

cd /home/user/deploy

echo "==============================="
echo " ${name}"
echo " ${url}"
echo "==============================="
if [ "x$CLEAN" = "x1" ]; then
    echo " CLEAN"
fi
if [ ! -d $name ]; then
echo " Clone"
echo "----------------------------------"
  git clone $url $name
  cd $name
  mvn install $@ || exit 1
else
  cd $name
  git remote update
  uptodate=$(git status |grep -c "Your branch is up to date")
  if [ "x$uptodate" = "x1" -a ! "x$CLEAN" = "x1" -a ! -e "/home/user/retry/$name" ]; then
    echo "Up-to-date"
    echo "----------------------------------"
  else
    echo " Compile"
    echo "----------------------------------"
    touch /home/user/retry/$name
    git pull
    if [ "x$CLEAN" = "x1" ]; then
      mvn clean $@ || exit 1
    else
      mvn install $@ || exit 1
    fi
    rm /home/user/retry/$name
    touch /home/user/done/$name
  fi
fi

cd ..
