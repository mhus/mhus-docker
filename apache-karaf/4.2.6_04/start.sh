#!/bin/bash

if [ "x$CONFIG_PROFILE" == "x" ]; then
  CONFIG_PROFILE=default
fi
export CONFIG_PROFILE

cd /opt/karaf

if [ "x$START_REINSTALL" == "x1" ]; then
  rm assembly.mark
  rm installdone.mark
  rm environmentdone.mark
fi

# prepare karaf
cd /opt/karaf
rm instances/instance.properties 

# assembly
cd /opt/karaf
if [ ! "x$PREVENT_ASSEMBLY" == "x1" -a ! -e assemblydone.mark ]; then
    /docker/assembly.sh
    if [  -e /docker/assembly_custom.sh ]; then
      /docker/assembly_custom.sh
    fi
fi
# environment
cd /opt/karaf
if [ ! "x$PREVENT_ENVIRONMENT" == "x1" -a ! -e environmentdone.mark ]; then
    /docker/environment.sh
    if [  -e /docker/environment_custom.sh ]; then
      /docker/environment_custom.sh
    fi
fi
# install
cd /opt/karaf
if [ ! "x$PREVENT_DEPLOY" == "x1" -a ! -e deploydone.mark ]; then
    /docker/deploy.sh
    if [  -e /docker/BUILD_custom.sh ]; then
      /docker/BUILD_custom.sh
    fi
fi

# Start Karaf

#echo "-------------------------------------"
#printenv

echo "-------------------------------------"
echo "Start Karaf ($$) $@"
echo "-------------------------------------"
export KARAF_EXEC=exec
exec ./bin/karaf $@
echo "-------------------------------------"
echo "Finish"
echo "-------------------------------------"
