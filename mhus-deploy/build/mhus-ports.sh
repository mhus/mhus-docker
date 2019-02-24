#!/bin/bash
._init.sh
mhus-lib.sh $@ || exit 1

_repo.sh mhus-ports https://github.com/mhus/mhus-ports.git $@ || exit 1
. _done.sh