#!/bin/bash

if [ -e /docker/assembly.tar.gz ]; then
    echo "- - - - - - - - - - - - - - - - - -"
    echo "Install Assembly"
    echo "- - - - - - - - - - - - - - - - - -"
    cd /opt/karaf
    rm -rf *
    tar --strip-components=1 -C /opt/karaf -xzvf /docker/assembly.tar.gz
    echo "- - - - - - - - - - - - - - - - - -"
fi
rm environmentdone.mark
rm deploydone.mark
touch assemblydone.mark
