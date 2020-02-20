#!/bin/sh

# write config file

if [ ! -e /etc/promtail/promtail.yaml ]; then
    IP=$(ip addr|grep inet|grep eth0|cut -d ' ' -f 6|cut -d / -f 1)
    mkdir /etc/promtail
    echo "scrape_configs:" >> /etc/promtail/promtail.yaml
    echo "  - job_name: system" >> /etc/promtail/promtail.yaml
    echo "    entry_parser: raw" >> /etc/promtail/promtail.yaml
    echo "    static_configs:" >> /etc/promtail/promtail.yaml
    echo "      - targets:" >> /etc/promtail/promtail.yaml
    echo "          - localhost" >> /etc/promtail/promtail.yaml
    echo "        labels:" >> /etc/promtail/promtail.yaml
    echo "          job: $LOG_JOB" >> /etc/promtail/promtail.yaml
    echo "          namespace: $LOG_NS" >> /etc/promtail/promtail.yaml
    echo "          __path__: $LOG_FILE_PATH" >> /etc/promtail/promtail.yaml
    echo "          hostname: $HOSTNAME" >> /etc/promtail/promtail.yaml
    echo "          ip: $IP" >> /etc/promtail/promtail.yaml
fi

exec /usr/bin/promtail -config.file=/etc/promtail/promtail.yaml -client.url=$LOG_URL
