## Features

* ubuntu:16.04
* apache-karaf 4.2.1
* open JDK 10.0.2.13 (https://hub.docker.com/r/adoptopenjdk/openjdk10)
* filebeat 6.2.3
* Use /deploy.gsh to deploy features at the first startup

## Create Image

```
./create.sh

docker tag apache-karaf-playground "mhus/apache-karaf-playground:4.2.1"
docker tag apache-karaf-playground "mhus/apache-karaf-playground:latest"

docker push "mhus/apache-karaf-playground:4.2.1"
docker push "mhus/apache-karaf-playground:latest"
```

## Start playground
```
docker run -it --name playground-karaf mhus/apache-karaf-playground:4.2.1
```
### Options

* -e "START_FILEBEAT=1" - Start filebeat
* -p 15005:5005 ... debug - Start in debug mode and open debug port at 15005
* -v /home/user/.m2:/root/.m2 - Share user local repository with karaf container

Examples:

```
docker run -it -v /home/user/.m2:/root/.m2 -p 15005:5005 --name playground-karaf apache-karaf-playground debug
```

Use the env START_FILEBEAT=1 to activate filebeat. Start the log environment before (see elasticstack)

```
docker run -it --link log-logstash:logstash -e "START_FILEBEAT=1" --name playground-karaf mhus/apache-karaf-playground:4.2.1
```

All together

```
docker run -it -v /home/user/.m2:/root/.m2 --link log-logstash:fb_logstash -e "START_FILEBEAT=1" -p 15005:5005 --name playground-karaf mhus/apache-karaf-playground:4.2.1 debug
```

## Start mhus

Start the container sharing the local repository. If you have compiled a SNAPSHOT release you can now install it

```
version=1.4.4-SNAPSHOT
feature:repo-add mvn:de.mhus.osgi/mhu-karaf-feature/$version/xml/features
feature:install mhu-osgi-base
```

