#!/bin/bash

mhus-osgi-tools.sh || exit 1

repo.sh mhus-transform https://github.com/mhus/mhus-transform.git || exit 1
