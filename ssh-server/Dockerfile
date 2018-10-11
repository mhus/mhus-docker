FROM       debian:9
MAINTAINER Mike Hummel <mh@mhus.de>
# https://github.com/rastasheep/ubuntu-sshd

RUN apt-get update \
 && apt-get install -y openssh-server

COPY start.sh /

run chmod u+x /start.sh \
 && mkdir /var/run/sshd \
 && echo "/bin/ping" >> /etc/shells \
 && useradd -ms /bin/ping client \
 && yes "asd123_$RANDOM$RANDOM" | passwd client \
 && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
 && echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/start.sh"]

