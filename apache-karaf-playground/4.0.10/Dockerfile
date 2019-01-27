FROM committed/java
MAINTAINER Mike Hummel <mh@mhus.de>

ENV FILEBEAT_VERSION=6.2.3 \
    JAVA_HOME=/usr/lib/jvm/java-8-oracle \
    KARAF_VERSION=4.0.10 \
    JAVA_MAX_MEM=2048m \
    KARAF_EXEC=exec \
    APP_NAME=app

COPY download.sh /tmp/download.sh

RUN set -x \
    && echo ">>> Install the Java JCE Policy" \
    && curl -q -L -C - -b "oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-8.zip -O http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip -oj -d /usr/lib/jvm/java-8-oracle/jre/lib/security /tmp/jce_policy-8.zip \*/\*.jar \
    && rm /tmp/jce_policy-8.zip \
    && echo ">>> Install linux tools" \
    && apt-get update && apt-get install -y --no-install-recommends jq wget curl less nano \
    && echo ">>> Install fileabeat" \
    && cd /opt \
    && wget --no-check-certificate -O filebeat.tar.gz https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
    && tar xzvf filebeat.tar.gz \
    && rm filebeat.tar.gz \
    && mv filebeat-${FILEBEAT_VERSION}-linux-x86_64 filebeat \
    && touch filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.version \
    && cd / \
    && echo ">>> Download and install karaf" \
    && chmod a+x /tmp/download.sh && sync && /tmp/download.sh && rm /tmp/download.sh \
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
COPY environment.sh /
COPY environment_folders.txt /

RUN set -x \
    && echo ">>> Prepare start" \
    && chmod u+x /start.sh \
    && chmod ugo+x /environment.sh

EXPOSE 8181

ENTRYPOINT ["/start.sh"]
CMD []

