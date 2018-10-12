FROM committed/java
MAINTAINER Mike Hummel <mh@mhus.de>

# Install the Java JCE Policy
RUN curl -q -L -C - -b "oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-8.zip -O http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip -oj -d /usr/lib/jvm/java-8-oracle/jre/lib/security /tmp/jce_policy-8.zip \*/\*.jar \
    && rm /tmp/jce_policy-8.zip

ENV KARAF_UID 1000
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV KARAF_VERSION 4.0.10
ENV JAVA_MAX_MEM 2048m
ENV KARAF_EXEC exec
ENV APP_NAME app

COPY download.sh /tmp/download.sh

RUN apt-get update && apt-get install -y --no-install-recommends jq curl vim less nano && rm -rf /var/lib/apt/lists/* \
    && chmod a+x /tmp/download.sh && sync && /tmp/download.sh && rm /tmp/download.sh \
    && mkdir -p /opt/karaf \
    && tar --strip-components=1 -C /opt/karaf -xzf /tmp/apache-karaf.tar.gz \
    && rm /tmp/apache-karaf.tar.gz \
    && mkdir -p /opt/karaf/data /opt/karaf/data/log \
    && mkdir -p /root/.m2/repository \
    && sed -i 's/log4j\.rootLogger=INFO,\ out,\ osgi\:\*/log4j\.rootLogger=INFO,\ out,\ stdout,\ osgi\:\*/' /opt/karaf/etc/org.ops4j.pax.logging.cfg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install karaf basic bundles
RUN find ~/.m2/repository \
	&& cd /opt/karaf \
	&& ./bin/start \
	&& sleep 2 \
	&& while [ "$(grep -c Done data/log/karaf.log)" = "0" ]; do echo "."; sleep 5; done \
	&& echo "feature:install webconsole" | ./bin/client \
	&& sleep 2 \
	&& ./bin/stop \
	&& sleep 5 \
	&& while [ "$(grep -c Stopping\ JMX\ OSGi\ agent data/log/karaf.log)" = "0" ]; do echo "."; sleep 5; done

COPY start.sh /start.sh
RUN echo "org.ops4j.pax.web.session.timeout=30" >> /opt/karaf/etc/org.ops4j.pax.web.cfg \
	&& chmod u+x /start.sh \
	&& rm -r /root/.m2/*

EXPOSE 8181

ENTRYPOINT ["/start.sh"]

