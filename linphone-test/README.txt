

kubectl run test --image mhus/linphone-test:0.2-amd64 --rm -it -- bash

root@test:/# linphone-daemon 2>/dev/null

daemon-linphone>register sip:username@sipregistry proxy password

daemon-linphone>call sip:004912345@sipregistry

daemon-linphone>incall-player-start /wav/audio-1.wav 1

# terminate the call by phone before the end of the wav file, linphone will crash otherwise

Test local:

docker run --rm -it mhus/linphone-test:0.3-amd64

Sources:

https://www.wavsource.com/tv/tv_misc1.htm

