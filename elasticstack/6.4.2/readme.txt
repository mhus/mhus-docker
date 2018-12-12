docker run -d -i -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" --name test-elastic docker.elastic.co/elasticsearch/elasticsearch:6.4.2

docker run -d -i -e "ELASTICSEARCH_URL=http://elasticsearch:9200" -p 15601:5601 --link test-elastic:elasticsearch --name test-kibana docker.elastic.co/kibana/kibana:6.4.2

docker run -d -i -p 5000:5000 --link test-elastic:elasticsearch --name test-logstash logstash

docker run -d -i --link test-logstash:logstash -v  /var/log:/log --name test-filebeat filebeat


--- access ---

docker exec -it --user root test-kibana /bin/bash

docker exec -it --user root test-logstash /bin/bash

docker exec -it --user root test-filebeat /bin/bash


--- create ---

docker build --build-arg UID=501 -t filebeat .
