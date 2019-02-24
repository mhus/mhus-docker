#!/bin/bash
. _init.sh
mhus-osgi-crypt.sh $@ || exit 1
mhus-ports.sh $@ || exit 1

_repo.sh cherry-vault https://github.com/mhus/cherry-vault.git $@ || exit 1
. _done.sh