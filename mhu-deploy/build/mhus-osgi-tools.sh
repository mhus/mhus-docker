#!/bin/bash

mhus-osgi-tools.sh || exit 1

repo.sh mhus-osgi-crypt https://github.com/mhus/mhus-osgi-crypt.git || exit 1
