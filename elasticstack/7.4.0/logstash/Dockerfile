FROM docker.elastic.co/logstash/logstash:7.4.0
MAINTAINER Mike Hummel <mh@mhus.de>

COPY pipeline/logstash.conf /usr/share/logstash/pipeline/

USER 0

RUN mkdir -p /logstash/files \
  && chmod 777 /logstash/files

USER 1000

RUN cd /usr/share/logstash \
  && bin/logstash-plugin install logstash-output-websocket
