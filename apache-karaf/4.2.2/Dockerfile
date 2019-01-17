FROM mhus/apache-karaf-playground:4.2.2
MAINTAINER Mike Hummel <mh@mhus.de>

ENV APP_UID=501

COPY start2.sh /

RUN set -x \
 && echo ">>> Install" \
 && useradd -u $APP_UID -ms /start.sh user \
 && chmod ugo+x /start2.sh \
 && chown -R user:user /opt/karaf \
 && mkdir -p /home/user/.m2/repository \
 && chown -R user:user /home/user/.m2

ENTRYPOINT ["/start2.sh"]
