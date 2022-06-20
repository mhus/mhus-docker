FROM debian
RUN set +x \
 && apt update \
 && apt install -y curl git \
 && (curl -sSL "https://github.com/buildpacks/pack/releases/download/v0.26.0/pack-v0.26.0-linux.tgz" | tar -C /usr/local/bin/ --no-same-owner -xzv pack) \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
ENTRYPOINT ["/usr/local/bin/pack"]
