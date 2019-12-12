## Features

* apache-karaf 4.2.6
* open JDK 11.0.5 (https://hub.docker.com/_/openjdk)
* filebeat 7.4.0
* Use /deploy[1..n].gogo to deploy features at the first startup or at install time

## Create Image

```
./create.sh

docker tag mhus/apache-karaf:4.2.6_03 "mhus/apache-karaf:latest"

docker push "mhus/apache-karaf:4.2.6_03"
docker push "mhus/apache-karaf:latest"
```

## Start karaf
```
docker run -it --name karaf mhus/apache-karaf:4.2.6_03
```
### Options

* -e "START_FILEBEAT=1" - Start filebeat
* -p 15005:5005 ... debug - Start in debug mode and open debug port at 15005
* -v /home/user/.m2:/root/.m2 - Share user local repository with karaf container

Examples:

```
docker run -it -v /home/user/.m2:/root/.m2 -p 15005:5005 --name karaf apache-karaf debug
```

Use the env START_FILEBEAT=1 to activate filebeat. Start the log environment before (see elasticstack)

```
docker run -it --link log-logstash:logstash -e "START_FILEBEAT=1" --name karaf mhus/apache-karaf:4.2.6_03
```

All together

```
docker run -it -v /home/user/.m2:/root/.m2 --link log-logstash:fb_logstash -e "START_FILEBEAT=1" -p 15005:5005 --name karaf mhus/apache-karaf:4.2.6_03 debug
```

## Start mhus

Start the container sharing the local repository. If you have compiled a SNAPSHOT release you can now install it

```
version=1.5.0-SNAPSHOT
feature:repo-add mvn:de.mhus.osgi/mhu-karaf-feature/$version/xml/features
feature:install mhu-osgi-base
```

