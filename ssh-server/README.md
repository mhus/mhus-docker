# ssh-server

A docker container with sshd server to allow remote ssh connections with tunnel options to connect the docker environment with external services.

The container copy the content of /ssh into the local ssh folder of the user 'client'. If the key id_rsa not exists it will create a new key at startup.

Create

./creats.sh

Usage

docker run -it -d -p 1022:22 -v $storage:/ssh --name ssh-server ssh-server
 
 Start ssh client
 
 ssh -i $storage/id_rsa -p 1022 client@localhost
 
 