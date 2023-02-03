FROM ubuntu

RUN apt update \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt -y install apt-utils \
 && apt -y install iputils-ping netcat wget vim iproute2 ngrep net-tools zsh gnupg\
 curl git htop screen dnsutils \
 && chsh -s /bin/zsh \
 && sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --keep-zshrc \
 && curl -L -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
 && chmod +x /usr/local/bin/kubectl \
 && echo "deb https://baltocdn.com/helm/stable/debian/ all main" > /etc/apt/sources.list.d/helm-stable-debian.list \
 && curl https://baltocdn.com/helm/signing.asc | apt-key add - \
 && apt update \
 && apt -y install helm \
 && curl -s https://fluxcd.io/install.sh | bash \
 && echo "End"

ADD files /

ENTRYPOINT [ "/usr/bin/zsh" ]