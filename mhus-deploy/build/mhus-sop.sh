#!/bin/bash
. _init.sh
mhus-transform.sh $@ || exit 1

_repo.sh mhus-sop https://github.com/mhus/mhus-sop.git $@ || exit 1
. _done.sh