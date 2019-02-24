#!/bin/bash
. _init.sh
mhus-osgi-tools.sh $@ || exit 1

_repo.sh mhus-transform https://github.com/mhus/mhus-transform.git $@ || exit 1
. _done.sh