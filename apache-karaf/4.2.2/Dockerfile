FROM mhus/apache-karaf-playground:4.2.2
MAINTAINER Mike Hummel <mh@mhus.de>

ARG APP_UID=501

RUN set -x \
 && echo ">>> Install" \
 && useradd -u $APP_UID -ms /start.sh user \
 && chown -R $APP_UID /opt/karaf \
 && mkdir -p /home/user/.m2/repository \
 && chown -R user /home/user/.m2/repository \
 && chmod ugo+x /install.sh \
 && chmod ugo+x /start.sh
 
USER $KARAF_UID

