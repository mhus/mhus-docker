#!/bin/bash
init.sh

mhus-transform.sh $@ || exit 1

repo.sh cherry-web https://github.com/mhus/cherry-web.git $@ || exit 1
