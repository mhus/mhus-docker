
## Create the images
```
docker build -t log-logstash logstash 

docker build --build-arg UID=501 -t log-filebeat filebeat
```
## Start environment

### Start elastic search
```
docker run -d -i \
 -e "discovery.type=single-node" \
 --name log-elastic \
 -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
 docker.elastic.co/elasticsearch/elasticsearch:7.4.2

docker run -d -i \
 -p 9200:9200 \
 -p 9300:9300 \
 -e "discovery.type=single-node" \
 -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
 --name log-elastic \
 docker.elastic.co/elasticsearch/elasticsearch:7.4.2

```
### Start kibana
```
docker run -d -i \
 -e "ELASTICSEARCH_URL=http://elasticsearch:9200" \
 -p 35601:5601 \
 --link log-elastic:elasticsearch \
 --name log-kibana \
 docker.elastic.co/kibana/kibana:7.4.2
```
You can access the UI in the browser with http://localhost:35601

### Start logstash
```
docker run -d -i \
 --link log-elastic:elasticsearch \
 -p 35001:5001 \
 -v  /tmp/logstash:/logstash \
 --name log-logstash \
 mhus/log-logstash:7.4.2

docker run -d -i \
 -p 35000:5000 \
 -p 35001:5001 \
 --link log-elastic:elasticsearch \
 --name log-logstash \
 mhus/log-logstash:7.4.2
```
### Start a filebeat

This filebeat is watching for your local log files

```
docker run -d -i \
 --link log-logstash:logstash \
 -v /var/log:/log \
 --name log-filebeat \
 log-filebeat
```

### Setup kibana

* Enter kibana page http://localhost:35601 and click 'Discover'
* The Dialog 'Step 1 of 2: Define index pattern' appears. Insert into the text field 'Index pattern' the name 'testindex'. Click 'Next Step'
* In 'Step 2 of 2: Configure settings' select '@timestamp' and click 'Create index pattern'
* Now you can discover and search the index


### Access the containers
```
docker exec -it --user root test-kibana /bin/bash

docker exec -it --user root test-logstash /bin/bash

docker exec -it --user root test-filebeat /bin/bash
```
## Mass Actions

### Remove All
```
docker rm log-logstash
docker rm log-kibana
docker rm log-elastic
```

## Misc

https://discuss.elastic.co/t/output-file-configuration/136269

https://www.elastic.co/guide/en/logstash/7.4/event-dependent-configuration.html#conditionals

