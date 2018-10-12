FROM       debian:9
MAINTAINER Mike Hummel <mh@mhus.de>

COPY start.sh /

RUN apt-get update \
 && apt-get install -y openssh-client nano \
 && chmod u+x /start.sh \
 && mkdir /ssh \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/start.sh"]

