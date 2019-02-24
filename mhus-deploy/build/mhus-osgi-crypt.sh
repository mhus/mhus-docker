#!/bin/bash
. _init.sh
mhus-osgi-tools.sh $@ || exit 1

_repo.sh mhus-osgi-crypt https://github.com/mhus/mhus-osgi-crypt.git $@ || exit 1
. _done.sh