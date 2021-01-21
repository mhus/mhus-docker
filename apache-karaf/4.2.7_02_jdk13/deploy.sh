#!/bin/bash
cd /opt/karaf

if [ -e /docker/deploy/deploy1.gogo ] || [ "x$BUILD_FORCE" == "x1" ]; then
    echo "====================================="
    echo "Deploy Features"
    echo "====================================="
    rm -r data/cache/*
    rm data/log/*
    rm -r saved_deploy
    mkdir saved_deploy
    mv deploy/* saved_deploy/
    echo "-------------------------------------"
    echo "Start karaf in background"
    echo "-------------------------------------"
    ./bin/start
    sleep 5
    (tail -f data/log/karaf.log) &
    while [ "$(grep -c Done data/log/karaf.log)" = "0" ]; do
      echo "."
      sleep 5
    done
    
    cnt=1
    
    while [ -e /docker/deploy/deploy${cnt}.gogo ]
    do
        echo "-------------------------------------"
        echo "Deploy file deploy${cnt}.gogo"
        echo "-------------------------------------"
        cat /docker/deploy/deploy${cnt}.gogo
        echo "-------------------------------------"
        cat /docker/deploy/deploy${cnt}.gogo | ./bin/client
        echo "-------------------------------------"
        echo "DEPLOY FINISHED"
        echo "-------------------------------------"
        
    #    for c in 1 2 3 4 5 6 7 8 9 10
    #    do
    #        echo Round $c
    #        echo "-------------------------------------"
    #        echo list | ./bin/client
    #        echo "-------------------------------------"
    #        sleep 1
    #    done
        sleep 10
        
        echo "-------------------------------------"
        echo "Actual Features"
        echo "-------------------------------------"
        echo list | ./bin/client
    
        let cnt=${cnt}+1
    done
    
    echo "-------------------------------------"
    echo "Deploy blueprints"
    echo "-------------------------------------"
    mv saved_deploy/* deploy/
    rm -r saved_deploy
    sleep 10
    
    echo "-------------------------------------"
    echo "Stop karaf"
    echo "-------------------------------------"
    ./bin/stop
    sleep 5
    cnt=0
    while [ "$(grep -c Stopping\ JMX\ OSGi\ agent data/log/karaf.log)" = "0" ]; do
      echo "."
      sleep 5
      let cnt=$cnt+1
      if [ $cnt -gt 30 ]; then
          killall -9 java
          sleep 2
          break
      fi
    done
    killall tail
fi
touch deploydone.mark
rm instances/instance.properties 
echo "====================================="
echo "Finished"
echo "====================================="
