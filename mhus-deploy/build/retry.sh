#!/bin/bash

cd /home/user

reset.sh

for i in $(ls deploy/); do echo $i; mkdir retry/$i; done
