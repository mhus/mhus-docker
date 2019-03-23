#!/bin/bash

name=$1
shift

url=$1
shift

function mavenQuit {
    echo "##############################"
    echo "## Maven Failed: $1"
    echo "##############################"
    if [ "x$DEPLOY_MAVEN_NOT_QUIT" = "x1" ]; then
        echo Ignore Maven Error
        echo "##############################"
        return
    fi
    exit 1
}

function gitQuit {
    echo "##############################"
    echo "## Git Failed: $1"
    echo "##############################"
    if [ "x$DEPLOY_GIT_NOT_QUIT" = "x1" ]; then
        echo Ignore Git Error
        echo "##############################"
        return
    fi
    exit 1
}

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
  echo "----------------------------------"
  echo " Clone $url $name"
  echo "----------------------------------"
  if [ "x$DEPLOY_GIT_DISABLED" = "x1" ]; then
      gitQuit clone_disabled
  else
    git clone $url $name || gitQuit clone
  fi
  cd $name
  echo "----------------------------------"
  echo " maven $@"
  echo "----------------------------------"
  if [ "x$DEPLOY_MAVEN_DISABLED" != "x1" ]; then
    mvn $@ || mavenQuit
  fi
else
  cd $name
  if [ "x$DEPLOY_GIT_DISABLED" = "x1" ]; then
    uptodate=1
  else
    git remote update
    status=$(git status)
    uptodate=$(git status |grep -c "up-to-date")
    echo GIT Status: $uptodate - $status
  fi
  if [ "x$uptodate" = "x1" -a ! -e "/home/user/retry/$name" ]; then
    echo "----------------------------------"
    echo "Up-to-date"
    echo "----------------------------------"
  else
    touch /home/user/retry/$name
    echo "----------------------------------"
    echo " maven $@"
    echo "----------------------------------"
    if [ "x$DEPLOY_GIT_DISABLED" != "x1" ]; then
      git pull || gitQuit pull
    fi
    if [ "x$DEPLOY_MAVEN_DISABLED" != "x1" ]; then
        mvn $@ || mavenQuit
    fi
  fi
fi

rm /home/user/retry/$name
touch /home/user/done/$name

cd ..
