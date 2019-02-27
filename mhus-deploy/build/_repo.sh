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


if [ ! -d $name ]; then
  touch /home/user/retry/$name
  echo " Clone"
  echo "----------------------------------"
  git clone $url $name
  cd $name
  mvn $@ || exit 1
else
  cd $name
  git remote update
  status=$(git status)
  uptodate=$(git status |grep -c "up-to-date")
  echo GIT Status: $uptodate - $status
  if [ "x$uptodate" = "x1" -a ! -e "/home/user/retry/$name" ]; then
    echo "Up-to-date"
    echo "----------------------------------"
  else
    touch /home/user/retry/$name
    echo " Compile"
    echo "----------------------------------"
    git pull || exit 1
    mvn $@ || exit 1
  fi
fi

rm /home/user/retry/$name
touch /home/user/done/$name

cd ..
