FROM debian:jessie
MAINTAINER Mike Hummel <mh@mhus.de>

ARG FILEBEAT_VERSION=6.4.2
ARG	UID=1000

COPY content/filebeat.yml /filebeat.yml
COPY start.sh /

RUN set -x \
    && echo ">>> Install linux tools" \
    && apt-get update && apt-get install -y --no-install-recommends wget curl less nano \
    && echo ">>> Install filebeat" \
    && cd / \
    && wget --no-check-certificate -O filebeat.tar.gz https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
    && tar -xzvf filebeat.tar.gz \
    && rm filebeat.tar.gz \
    && mv filebeat-${FILEBEAT_VERSION}-linux-x86_64 filebeat \
    && touch filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.version \
    && chown -R $UID filebeat \
	&& echo ">>> Prepare start" \
	&& chmod +x /start.sh \
    && mkdir /log \
	&& echo ">>> Cleanup" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $UID

ENTRYPOINT ["/start.sh"]
