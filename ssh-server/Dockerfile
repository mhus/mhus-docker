FROM       debian:9
MAINTAINER Mike Hummel <mh@mhus.de>
# https://github.com/rastasheep/ubuntu-sshd

COPY start.sh /
COPY ping.sh /

RUN apt-get update \
 && apt-get install -y openssh-server nano \
 && chmod u+x /start.sh \
 && chmod 777 /ping.sh \
 && mkdir /var/run/sshd \
 && useradd -ms /ping.sh client \
 && yes "asd123_$RANDOM$RANDOM" | passwd client \
 && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
 && echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config \
 && echo 'GatewayPorts yes' >> /etc/ssh/sshd_config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

ENTRYPOINT ["/start.sh"]

