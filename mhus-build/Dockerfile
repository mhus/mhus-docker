FROM openjdk:11.0.7-jdk
MAINTAINER Mike Hummel

ENV APP_UID=501

RUN set -x \
  && apt-get update && apt-get install -y --no-install-recommends jq wget curl nano psmisc git maven vim less \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && useradd -u $APP_UID -ms /bin/bash user \
  && mkdir /home/user/build \
  && mkdir /home/user/retry \
  && mkdir /home/user/done \
  && mkdir /home/user/bin \
  && su -c "curl https://repo1.maven.org/maven2/de/mhus/conductor/conductor-launcher/1.1.0/conductor-launcher-1.1.0-install.sh | bash" user \
  && rm -rf /home/user/.m2/repository/*
  
COPY bin /home/user/bin/
COPY start.sh /start.sh
COPY bash_aliases /home/user/.bash_aliases

RUN set -x \
  && chown -R $APP_UID /home/user \
  && chmod +x /start.sh \
  && ln -s /home/user/.conductor/bin/con /home/user/bin/con

USER 0
ENTRYPOINT ["/start.sh"]
CMD []
