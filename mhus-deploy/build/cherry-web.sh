#!/bin/bash
. _init.sh
mhus-transform.sh $@ || exit 1

_repo.sh cherry-web https://github.com/mhus/cherry-web.git $@ || exit 1
._done.sh