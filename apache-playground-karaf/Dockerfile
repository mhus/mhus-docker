FROM committed/java
MAINTAINER Mike Hummel <mh@mhus.de>


#ENV KARAF_UID 0
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV KARAF_VERSION 4.0.10
ENV JAVA_MAX_MEM 2048m
ENV KARAF_EXEC exec
ENV APP_NAME app

COPY download.sh /tmp/download.sh
COPY start.sh /
COPY install.go /
COPY karaf /opt/karaf/

RUN echo ">>> Install the Java JCE Policy" \
    && curl -q -L -C - -b "oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-8.zip -O http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip -oj -d /usr/lib/jvm/java-8-oracle/jre/lib/security /tmp/jce_policy-8.zip \*/\*.jar \
    && rm /tmp/jce_policy-8.zip \
    && echo ">>> Install linux tools" \
    && apt-get update && apt-get install -y --no-install-recommends jq curl nano less nano && rm -rf /var/lib/apt/lists/* \
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

EXPOSE 8181

ENTRYPOINT ["/start.sh"]

