FROM openjdk:11.0.2-jdk
MAINTAINER Mike Hummel

ENV APP_UID=501

RUN set -x \
  && apt-get update && apt-get install -y --no-install-recommends jq wget curl nano psmisc git maven vim less \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && useradd -u $APP_UID -ms /start.sh user \
  && mkdir /home/user/deploy \
  && mkdir /home/user/retry \
  && mkdir /home/user/done \
  && mkdir /home/user/build
  
COPY build /home/user/build/
COPY start.sh /start.sh

RUN set -x \
  && chown -R $APP_UID /home/user \
  && chmod +x /start.sh

#USER $APP_UID
ENTRYPOINT ["/start.sh"]
