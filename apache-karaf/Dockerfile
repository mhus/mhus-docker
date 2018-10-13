FROM mhus/apache-karaf-playground:4.0.10
MAINTAINER Mike Hummel <mh@mhus.de>

ENV KARAF_UID 1000

RUN set -x \
 && echo ">>> Install" \
 && useradd -u $KARAF_UID -ms /start.sh karaf \
 && chown -R $KARAF_UID /opt/karaf \
 && chown -R root /opt/karaf/bin \
 && chown -R root /opt/karaf/lib \
 && chown -R root /opt/karaf/system \
 && mkdir -p /home/karaf/.m2/repository \
 && chown -R karaf /home/karaf/.m2/repository \
 && chmod ugo+x /start.sh
 
EXPOSE 8181

USER $KARAF_UID

