#!/bin/bash

mhus-transform.sh || exit 1
mhus-ports.sh || exit 1

repo.sh cherry-reactive https://github.com/mhus/cherry-reactive.git || exit 1
