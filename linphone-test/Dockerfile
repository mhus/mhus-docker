FROM ubuntu

RUN apt update \
 && apt -y install iputils-ping netcat wget vim iproute2 linphone-nogtk sngrep ngrep net-tools \
 && mkdir -p /root/.local/share/linphone/

ADD wav wav
ADD scripts .
