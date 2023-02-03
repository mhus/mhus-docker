FROM ubuntu

RUN apt update \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt -y install apt-utils \
 && apt -y install iputils-ping netcat wget vim iproute2 linphone-nogtk sngrep ngrep net-tools zsh \
 curl git htop screen dnsutils awscli apt-transport-https ca-certificates gnupg hcloud-cli \
 && mkdir -p /root/.local/share/linphone/ \
 && chsh -s /bin/zsh \
 && sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --keep-zshrc \
 && curl -L -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
 && chmod +x /usr/local/bin/kubectl \
 && sh -c "$(wget https://get.docker.com -O -)" \
 && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
 && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
 && echo "deb https://baltocdn.com/helm/stable/debian/ all main" > /etc/apt/sources.list.d/helm-stable-debian.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg > /usr/share/keyrings/cloud.google.gpg \
 && curl https://baltocdn.com/helm/signing.asc | apt-key add - \
 && apt update \
 && apt -y install google-cloud-cli helm \
 && curl -s https://fluxcd.io/install.sh | bash \
 && echo "End"

ADD files /

ENTRYPOINT [ "/usr/bin/zsh" ]