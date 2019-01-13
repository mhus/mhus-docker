#!/bin/bash

mhus-crypt.sh || exit 1
mhus-ports.sh || exit 1

repo.sh cherry-vault https://github.com/mhus/cherry-vault.git || exit 1
