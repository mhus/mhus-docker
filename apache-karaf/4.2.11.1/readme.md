## Features

* apache-karaf 4.2.11
* open JDK 11.0.11 (https://hub.docker.com/_/openjdk)
* Use /docker/deploy[1..n].gogo to deploy features at the first startup or at install time
* Use /docker/assembly.tar.gz as karaf distribution
* Define multiple profiles in /docker/profiles

## Create Image

```
./create.sh

docker tag mhus/apache-karaf:4.2.11.1 "mhus/apache-karaf:latest"

docker push "mhus/apache-karaf:4.2.11.1"
docker push "mhus/apache-karaf:latest"
```

## Start karaf
```
docker run -it --name karaf mhus/apache-karaf:4.2.11.1
```


### Options

* -p 15005:5005 ... debug - Start in debug mode and open debug port at 15005
* -v /home/user/.m2:/root/.m2 - Share user local repository with karaf container

Examples:

```
docker run -it -v ~/.m2:/home/user/.m2 -p 15005:5005 -p 18181:8181 --name karaf mhus/apache-karaf:4.2.11.1 debug
```

## Start mhus

Start the container sharing the local repository. If you have compiled a SNAPSHOT release you can now install it

```
version=7.4.0-SNAPSHOT
feature:repo-add mvn:de.mhus.osgi/mhus-features/$version/xml/features
feature:install mhu-base
```

## Enhance image

To enhance the image you have to create a new Dockerfile and add the first instruction

```
FROM mhus/apache-karaf:4.2.11.1
```

The script starts in five steps

1. Initial script with root access, update UID if needed and chown to all files in /opt/karaf
2. Install the assembly, this will be done once
3. Copy environment from /docker/profile/... into the karaf directory and replace placeholders ${ENV_....} with values, this will be done once
4. If needed deploy/execute scripts from /docker/deploy, this will be done once
5. Start karaf

Steps 2 - 4 will leave marks in /opt/karaf if done.

* assemblydone.mark
* environmentdone.mark
* deploydone.mark

in your Dockerfile you can execute these steps to prepare for a fast start. It makes sense to install the assembly and start it once. 

```
RUN /docker/assembly.sh
RUN export BUILD_FORCE=1 && /docker/deploy.sh
```

Environment will be done after start of the container. It depends of the given environment. The environment 'BUILD_FORCE=1' will force the start of karaf even if no deploy file is given in /docker/deploy


## Profiles

The environment step will copy files out of the default profile, located in /docker/profiles/default, into the /opt/karaf folder. If you create the docker container you can change the name of the profile by set the environment variable CONFIG_PROFILE.

For example CONFIG_PROFILE=standalone will copy the files from /docker/profiles/standalone




