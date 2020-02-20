FROM grafana/promtail

RUN set +x \
 && apt update \
 && apt install -y --no-install-recommends iproute2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

ADD start.sh /start.sh
RUN chmod u+x /start.sh

ENTRYPOINT ["/start.sh"]
CMD []
