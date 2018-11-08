
from https://github.com/scollazo/docker-naxsi-waf-with-ui

start: 

docker run -it -d --name ssl-proxy -p 1081:1081 -e REMOTE_SERVER=web:8181 --link other-web-container:web ssl-proxy


created certificate:

openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj '/CN=localhost' -nodes
