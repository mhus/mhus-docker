#!/bin/bash

# keygen if not exists
if [ ! -e /ssh/authorized_keys ]
then
  ssh-keygen -t rsa -b 4096 -C client@noreply.com -f /ssh/id_rsa -P ''
  touch /ssh/authorized_keys
  cat /ssh/id_rsa.pub >> /ssh/authorized_keys
  echo "COPY and ERASE /ssh/id_rsa"
fi

# security
yes "asd123_$RANDOM$RANDOM" | passwd client

# copy into local ssh directory

rm -rf /home/client/.ssh
mkdir /home/client/.ssh
chmod 700 /home/client/.ssh
cp /ssh/* /home/client/.ssh
chmod 600 /home/client/.ssh/*
chown -R client /home/client/.ssh

/usr/sbin/sshd -D -e $@
