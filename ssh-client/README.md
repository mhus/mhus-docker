# ssh-client

A docker container with ssh client to permanently open a ssh connection

Create

./creats.sh

Usage

docker run -it -d -v $storage:/ssh --name ssh-client ssh-client -i /ssh/id_rsa -p 1022 -R 8888:container:8888 client@$host
 
 Start ssh client
 
 ssh -i $storage/id_rsa -p 1022 client@localhost
 
 