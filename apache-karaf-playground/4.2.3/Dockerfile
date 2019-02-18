FROM openjdk:11.0.2-jdk
MAINTAINER Mike Hummel <mh@mhus.de>

ARG BUILD_FILEBEAT_VERSION=6.5.4
ARG BUILD_KARAF_VERSION=4.2.3
ENV JAVA_MAX_MEM=2048m
ENV APP_NAME=karaf_playground
# for jdk9 and above, debug also from other then localhost
ENV JAVA_DEBUG_PORT=*:5005
# to shutdown graceful use exec in start script
ENV KARAF_EXEC="exec"

RUN set -x \
    && echo ">>> Install linux tools" \
    && apt-get update && apt-get install -y --no-install-recommends sudo jq wget curl less nano psmisc \
    && echo ">>> Install fileabeat" \
    && cd /opt \
    && wget --no-check-certificate -O filebeat.tar.gz https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${BUILD_FILEBEAT_VERSION}-linux-x86_64.tar.gz \
    && tar xzvf filebeat.tar.gz \
    && rm filebeat.tar.gz \
    && mv filebeat-${BUILD_FILEBEAT_VERSION}-linux-x86_64 filebeat \
    && touch filebeat/filebeat-${BUILD_FILEBEAT_VERSION}-linux-x86_64.version \
    && cd / \
    && echo ">>> Download and install karaf" \
    && url="http://archive.apache.org/dist/karaf/${BUILD_KARAF_VERSION}/apache-karaf-${BUILD_KARAF_VERSION}.tar.gz" \
    && curl -s -o "/tmp/apache-karaf.tar.gz" "${url}" \
    && mkdir -p /opt/karaf \
    && tar --strip-components=1 -C /opt/karaf -xzf /tmp/apache-karaf.tar.gz \
    && rm /tmp/apache-karaf.tar.gz \
    && mkdir -p /opt/karaf/data /opt/karaf/data/log \
    && mkdir -p /root/.m2/repository \
    && echo ">>> Cleanup" \
    && rm -r /root/.m2/* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo ">>> Setup" \
    && mkdir -p /docker/deploy

COPY karaf /opt/karaf/
COPY filebeat /docker
COPY start.sh /docker
COPY install.sh /docker
COPY environment.sh /docker
COPY environment_folders.txt /docker

RUN set -x \
    && echo ">>> Prepare start" \
    && chmod ugo+x /docker/start.sh \
    && chmod ugo+x /docker/install.sh \
    && chmod ugo+x /docker/environment.sh

EXPOSE 8181

ENTRYPOINT ["/docker/start.sh"]
CMD []
