Use this image to create a simple sidecar to your service.

The promtail is configured fully by environment variables currently supported:

* LOG_NS - Namespace (label 'namespace')
* LOG_JOB - Name of the JOB (label 'job')
* LOG_FILE_PATH - Path to the log file inside of the container
* LOG_URL - Where to send the Log to, usually the loki.namespace.svc.cluster.local url

Additional the image will add the labels

* ip - current ip address to identify a single pod
* hostname - the hostname

Example kube config:

```
      - name: server
        ...
        volumeMounts:
        - name: shared-logs
          mountPath: /opt/data/log
      - name: promtail-container
        image: mhus/promtail-sidecar:1.0.0
        env:
        - name: LOG_NS
          value: "reactive-test"
        - name: LOG_JOB
          value: "myserverjob"
        - name: LOG_FILE_PATH
          value: "/home/slog/server.log"
        - name: LOG_URL
          value: "http://loki.monitoring.svc.cluster.local:3100/api/prom/push"
        volumeMounts:
        - name: shared-logs
          mountPath: /home/slog
      volumes:
      - name: shared-logs
        emptyDir: {}
```
 