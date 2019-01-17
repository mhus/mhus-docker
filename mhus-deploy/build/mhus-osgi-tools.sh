#!/bin/bash
init.sh

mhus-lib.sh $@ || exit 1

repo.sh mhus-osgi-tools https://github.com/mhus/mhus-osgi-tools.git $@ || exit 1
