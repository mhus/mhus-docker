FROM apache-karaf-playground:4.2.3
MAINTAINER Mike Hummel <mh@mhus.de>

ENV APP_UID=501

COPY start2.sh /docker

RUN set -x \
 && echo ">>> Install" \
 && useradd -u $APP_UID -ms /docker/start.sh user \
 && chmod ugo+x /docker/start2.sh \
 && chown -R user:user /opt/karaf \
 && mkdir -p /home/user/.m2/repository \
 && chown -R user:user /home/user/.m2 \
 && mkdir /opt/filebeat/data \
 && chown -R user:user /opt/filebeat/data

ENTRYPOINT ["/docker/start2.sh"]
