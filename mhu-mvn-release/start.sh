#!/bin/bash

echo 1 Check License  : mvn license:format
echo 2 Check sources  : mvn clean install
echo 3 Change Version : mvn versions:set -DnewVersion=....
echo 4 Install Release: mvn clean install -P release
echo 5 Deploy Release : mvn deploy -P release
echo 6 git commit + tag version
echo 7 Change Version : mvn versions:set -DnewVersion=....-SNAPSHOT
echo 8 git commit

alias ll='ls -l'
cd /deploy
/bin/bash $@
