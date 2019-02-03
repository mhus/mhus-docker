FROM adoptopenjdk/openjdk10:jdk-10.0.2.13
MAINTAINER Mike Hummel <mh@mhus.de>

ARG FILEBEAT_VERSION=6.5.4
ARG KARAF_VERSION=4.2.2
ENV JAVA_MAX_MEM=2048m
ENV APP_NAME=karaf_playground
ENV JAVA_DEBUG_PORT=*:5005

RUN set -x \
    && echo ">>> Install linux tools" \
    && apt-get update && apt-get install -y --no-install-recommends sudo jq wget curl less nano psmisc \
    && echo ">>> Install fileabeat" \
    && cd /opt \
    && wget --no-check-certificate -O filebeat.tar.gz https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
    && tar xzvf filebeat.tar.gz \
    && rm filebeat.tar.gz \
    && mv filebeat-${FILEBEAT_VERSION}-linux-x86_64 filebeat \
    && touch filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.version \
    && cd / \
    && echo ">>> Download and install karaf" \
    && mirror=$(curl --stderr /dev/null https://www.apache.org/dyn/closer.cgi\?as_json\=1 | jq -r '.preferred') \
    && url="${mirror}karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz" \
    && curl -s -o "/tmp/apache-karaf.tar.gz" "${url}" \
    && mkdir -p /opt/karaf \
    && tar --strip-components=1 -C /opt/karaf -xzf /tmp/apache-karaf.tar.gz \
    && rm /tmp/apache-karaf.tar.gz \
    && mkdir -p /opt/karaf/data /opt/karaf/data/log \
    && mkdir -p /root/.m2/repository \
	&& echo ">>> Cleanup" \
	&& rm -r /root/.m2/* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY karaf /opt/karaf/
COPY filebeat /
COPY start.sh /
COPY install.sh /
COPY environment.sh /
COPY environment_folders.txt /

RUN set -x \
    && echo ">>> Prepare start" \
    && chmod ugo+x /start.sh \
    && chmod ugo+x /install.sh \
    && chmod ugo+x /environment.sh

EXPOSE 8181

ENTRYPOINT ["/start.sh"]
CMD []
