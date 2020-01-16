FROM openjdk:11.0.5-jdk
MAINTAINER Mike Hummel <mh@mhus.de>

ENV APP_UID=501

ARG BUILD_FILEBEAT_VERSION=7.4.0
ARG BUILD_KARAF_VERSION=4.2.6
ENV JAVA_MAX_MEM=2048m
ENV APP_NAME=karaf
# for jdk9 and above, debug also from other then localhost
ENV JAVA_DEBUG_PORT=*:5005

RUN set -x \
    && echo ">>> Install linux tools" \
    && apt-get update && apt-get install -y --no-install-recommends sudo jq wget curl less nano psmisc \
    && echo ">>> Setup" \
    && mkdir -p /docker/deploy \
    && mkdir -p /docker/deploy/profiles/default \
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
    && wget -O "/tmp/apache-karaf.tar.gz" "${url}" \
    && mkdir -p /opt/karaf \
    && mv /tmp/apache-karaf.tar.gz /docker/assembly.tar.gz \
    && mkdir -p /root/.m2/repository \
    && echo ">>> Cleanup" \
    && rm -r /root/.m2/* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY karaf /docker/profiles/default
COPY karaf /docker/profiles/initial
COPY filebeat /docker
COPY start.sh /docker
COPY start2.sh /docker
COPY deploy.sh /docker
COPY environment.sh /docker
COPY environment_folders.txt /docker
COPY assembly.sh /docker

RUN set -x \
    && echo ">>> Prepare start" \
    && chmod ugo+x /docker/start.sh \
    && chmod ugo+x /docker/deploy.sh \
    && chmod ugo+x /docker/environment.sh \
    && chmod ugo+x /docker/assembly.sh \
    && useradd -u $APP_UID -ms /docker/start.sh user \
    && chmod ugo+x /docker/start2.sh \
    && chown -R user:user /opt/karaf \
    && mkdir -p /home/user/.m2/repository \
    && chown -R user:user /home/user/.m2 \
    && mkdir /opt/filebeat/data \
    && chown -R user:user /opt/filebeat/data

EXPOSE 8181

ENTRYPOINT ["/docker/start2.sh"]
CMD []
