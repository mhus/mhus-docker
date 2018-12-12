## Features

* debian:jessie
* apache-karaf 4.0.10
* oracle jdk 1.8.0_111
* JCE installed
* filebeat 6.2.3

## Create Image

```
./create.sh

docker tag apache-karaf-playground "mhus/apache-karaf-playground:4.0.10"
docker tag apache-karaf-playground "mhus/apache-karaf-playground:latest"

docker push "mhus/apache-karaf-playground:4.0.10"
docker push "mhus/apache-karaf-playground:latest"
```

## Start playground
```
docker run -it --name playground-karaf apache-karaf-playground
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
docker run -it --link log-logstash:fb_logstash -e "START_FILEBEAT=1" --name playground-karaf apache-karaf-playground
```

All together

```
docker run -it -v /home/user/.m2:/root/.m2 --link log-logstash:fb_logstash -e "START_FILEBEAT=1" -p 15005:5005 --name playground-karaf apache-karaf-playground debug
```

## Start mhus

Start the container sharing the local repository. If you have compiled a SNAPSHOT release you can now install it

```
version=1.4.4-SNAPSHOT
feature:repo-add mvn:de.mhus.osgi/mhu-karaf-feature/$version/xml/features
feature:install mhu-osgi-base
```

