FROM committed/java
MAINTAINER Mike Hummel <mh@mhus.de>

ENV FILEBEAT_VERSION=6.2.3 \
    FILEBEAT_SHA1=9c87d44e47fb2e48f9d772449a72de5148d83b2e906ec673e4832d2d284ecc9643a6ca4df6600d30b79558c2ca233b94a88c2a3e4e195f2d396bdbbdcf4b6689 \
    JAVA_HOME=/usr/lib/jvm/java-8-oracle \
    KARAF_VERSION=4.0.10 \
    JAVA_MAX_MEM=2048m \
    KARAF_EXEC=exec \
    APP_NAME=app

COPY download.sh /tmp/download.sh
COPY start.sh /

RUN set -x \
    && echo ">>> Install the Java JCE Policy" \
    && curl -q -L -C - -b "oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-8.zip -O http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip -oj -d /usr/lib/jvm/java-8-oracle/jre/lib/security /tmp/jce_policy-8.zip \*/\*.jar \
    && rm /tmp/jce_policy-8.zip \
    && echo ">>> Install linux tools" \
    && apt-get update && apt-get install -y --no-install-recommends jq wget curl less nano && rm -rf /var/lib/apt/lists/* \
    && echo ">>> Install fileabeat" \
    && wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -O /opt/filebeat.tar.gz \
    && cd /opt \
    && echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha512sum -c - \
    && tar xzvf filebeat.tar.gz \
    && cd filebeat-* \
    && cp filebeat /bin \
    && cd / \
    && echo ">>> Download and install karaf" \
    && chmod a+x /tmp/download.sh && sync && /tmp/download.sh && rm /tmp/download.sh \
    && mkdir -p /opt/karaf \
    && tar --strip-components=1 -C /opt/karaf -xzf /tmp/apache-karaf.tar.gz \
    && rm /tmp/apache-karaf.tar.gz \
    && mkdir -p /opt/karaf/data /opt/karaf/data/log \
    && mkdir -p /root/.m2/repository \
	&& echo ">>> Prepare start" \
	&& chmod u+x /start.sh \
	&& echo ">>> Cleanup" \
	&& rm -r /root/.m2/* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY karaf /opt/karaf/

EXPOSE 8181

ENTRYPOINT ["/start.sh"]

