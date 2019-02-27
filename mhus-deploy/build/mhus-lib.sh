#!/bin/bash
. _init.sh
_repo.sh mhus-lib https://github.com/mhus/mhus-lib.git $@ || exit 1
. _done.sh