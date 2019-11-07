FROM docker.elastic.co/logstash/logstash:7.4.0
MAINTAINER Mike Hummel <mh@mhus.de>

COPY pipeline/logstash.conf /usr/share/logstash/pipeline/
RUN mkdir -p /logstash/files \
  && chmod 777 /logstash/files \
  && cd /usr/share/logstash \
  && bin/logstash-plugin install logstash-output-websocket

