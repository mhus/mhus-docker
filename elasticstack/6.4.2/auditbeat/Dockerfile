FROM debian:jessie
MAINTAINER Mike Hummel <mh@mhus.de>

ARG AUDITBEAT_VERSION=6.4.2
# Have to run as root
ARG	UID=0

COPY content/auditbeat.yml /auditbeat.yml
COPY start.sh /

RUN set -x \
    && echo ">>> Install linux tools" \
    && apt-get update && apt-get install -y --no-install-recommends wget curl less nano \
    && echo ">>> Install auditbeat" \
    && cd / \
    && wget --no-check-certificate -O auditbeat.tar.gz https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-${AUDITBEAT_VERSION}-linux-x86_64.tar.gz \
    && tar -xzvf auditbeat.tar.gz \
    && rm auditbeat.tar.gz \
    && mv auditbeat-${AUDITBEAT_VERSION}-linux-x86_64 auditbeat \
    && touch auditbeat/auditbeat-${AUDITBEAT_VERSION}-linux-x86_64.version \
    && chown -R $UID auditbeat \
	&& echo ">>> Prepare start" \
	&& chmod +x /start.sh \
    && mkdir /log \
	&& echo ">>> Cleanup" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $UID

ENTRYPOINT ["/start.sh"]
