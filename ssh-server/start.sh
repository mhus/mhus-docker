rm -rf /home/client/.ssh
mkdir /home/client/.ssh
chmod 700 /home/client/.ssh
cp /ssh/* /home/client/.ssh
chmod 600 /home/client/.ssh/*

/usr/sbin/sshd -D $@
