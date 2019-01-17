#!/bin/bash

mhus-transform.sh $@ || exit 1

repo.sh mhus-sop https://github.com/mhus/mhus-sop.git $@ || exit 1
