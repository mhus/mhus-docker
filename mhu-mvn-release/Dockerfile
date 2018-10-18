FROM sgrio/java-oracle:jdk_8
MAINTAINER Mike Hummel <mh@mhus.de>

COPY deploy.sh /deploy.sh
COPY start.sh /

RUN set -x \
    && echo ">>> Install the Java JCE Policy" \
    && curl -q -L -C - -b "oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-8.zip -O http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip -oj -d /usr/lib/jvm/java-8-oracle/jre/lib/security /tmp/jce_policy-8.zip \*/\*.jar \
    && rm /tmp/jce_policy-8.zip \
    && echo ">>> Install linux tools" \
    && apt-get update && apt-get install -y --no-install-recommends jq wget curl less nano vim maven \
	&& echo ">>> Prepare fs" \
	&& chmod u+x /start.sh \
	&& mkdir deploy && chmod u+x /deploy.sh
	&& echo ">>> Cleanup" \
	&& rm -r /root/.m2/* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
ENTRYPOINT ["/start.sh"]
