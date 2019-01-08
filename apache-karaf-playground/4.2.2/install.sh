cd /opt/karaf \
&& ./bin/start \
&& sleep 2 \
&& (tail -f /opt/karaf/data/log/karaf.log &) \
&& echo "Wait for startup 1" \
&& while [ "$(grep -c Done data/log/karaf.log)" = "0" ]; do echo "."; sleep 10; done \
&& sleep 5 \
&& ./bin/stop \
&& echo "Wait for shutdown 1" \
&& sleep 5 \
&& while [ "$(ps -efa | grep -v grep | grep -c java)" != "0" ]; do echo "."; sleep 5; done \
&& rm -r /opt/karaf/data/log/* \
&& ./bin/start \
&& sleep 2 \
&& (tail -f /opt/karaf/data/log/karaf.log &) \
&& echo "Wait for startup 2" \
&& while [ "$(grep -c Done data/log/karaf.log)" = "0" ]; do echo "."; sleep 10; done \
&& sleep 5 \
&& ./bin/stop \
&& echo "Wait for shutdown 2" \
&& sleep 5 \
&& while [ "$(ps -efa | grep -v grep | grep -c java)" != "0" ]; do echo "."; sleep 5; done \
&& rm -r ~/.m2/repository/* \
&& rm -r /opt/karaf/data/log/* 
