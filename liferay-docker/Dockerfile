FROM mhus/openjdk8:1.0

ENV DOCKERVERSION=18.03.1-ce
RUN set +x \
 && apt update \
 && apt -y install p7zip unzip \
 && curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
 && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 -C /usr/local/bin docker/docker \
 && rm docker-${DOCKERVERSION}.tgz 
# && mv docker /usr/bin/

COPY builder /root/builder
COPY start.sh /

RUN set +x \
 && chmod +x /root/builder/*.sh \
 && ln -s /usr/bin/p7zip /usr/bin/7z \
 && chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
 

