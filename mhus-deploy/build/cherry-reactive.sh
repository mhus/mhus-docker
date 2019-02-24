#!/bin/bash
. _init.sh
mhus-sop.sh $@ || exit 1
mhus-transform.sh $@ || exit 1
mhus-ports.sh $@ || exit 1

_repo.sh cherry-reactive https://github.com/mhus/cherry-reactive.git $@ || exit 1
. _done.sh