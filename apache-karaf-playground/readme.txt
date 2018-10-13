
./create.sh

docker tag apache-karaf-playground "mhus/apache-karaf-playground:4.0.10"
docker tag apache-karaf-playground "mhus/apache-karaf-playground:latest"

docker push "mhus/apache-karaf-playground:4.0.10"
docker push "mhus/apache-karaf-playground:latest"

== Start playground with logstash

# https://www.elastic.co/guide/en/elasticsearch/reference/6.4/docker.html#docker-prod-cluster-composefile
docker run -d -i -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" --name playground-elastic docker.elastic.co/elasticsearch/elasticsearch:6.4.2

# https://www.elastic.co/guide/en/kibana/6.4/docker.html
docker run -d -i -e "ELASTICSEARCH_URL=http://elasticsearch:9200" -p 15601:5601 --link playground-elastic:elasticsearch --name playground-kibana docker.elastic.co/kibana/kibana:6.4.2

# https://www.elastic.co/guide/en/logstash/6.4/docker-config.html
docker run -d -i --link playground-elastic:elasticsearch --name playground-logstash docker.elastic.co/logstash/logstash:6.4.2

docker run -it --link playground-logstash:fb_logstash -e "START_FILEBEAT=1" --name playground-karaf apache-karaf-playground


