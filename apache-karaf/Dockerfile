FROM mhus/apache-karaf-playground:4.0.10
MAINTAINER Mike Hummel <mh@mhus.de>

ENV KARAF_UID 1000

RUN echo ">>> Install" \
 && useradd -u $KARAF_UID -ms /start.sh karaf \
 && chown -R $KARAF_UID /opt/karaf/data \
 && mkdir -p /home/karaf/.m2/repository \
 && chown -R karaf /home/karaf/.m2/repository

EXPOSE 8181

USER $KARAF_UID

