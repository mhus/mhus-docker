# Usage

## Scope

Use the image to compile your java projects. It's configured to load and build the mhus project. 
It knows about dependencies and will only recompile if the source is changed. By default 
it will stop on error.

## Environment

The deploy image 11.x uses an openjdk 11 to deploy the projects. Currently it supports 
maven 3 and git.

## Start the container

Simple command to start the container:

```
docker run -it --name mhus-deploy \
 -h deploy-mhus \
 mhus/mhus-deploy:11.2
```

The command will start the container and you can start compiling. Before you start 
think about maven configuration and contribution of the compiled artifacts.

Therefore you should share the local maven directory with the host/others.

```
docker run -it --name mhus-deploy \
 -h deploy-mhus \
 -v ~/m2:/home/user/.m2 \
 mhus/mhus-deploy:11.2
```

You can also share the deploy folder to store the downloaded sources in a persistent 
place.

```
DATA=/mnt/storage/deploy

mkdir -p $DATA/m2
mkdir -p $DATA/deploy

docker run -it --name mhus-deploy \
 -h deploy-mhus \
 -v $DATA/m2:/home/user/.m2 \
 -v $DATA/deploy:/home/user/deploy \
 mhus/mhus-deploy:11.2
```

The last example uses a central directory for packages and also for sources.

In the examples the user id 501 is used to write the files. If you need to change the 
users id set the environment variable -e APP_UID=1234 to another user id. Do not use 
0 for root.

A common user id is also 1000:

```
docker run -it --name mhus-deploy \
 -h deploy-mhus \
 -e APP_UID=1000 \
 mhus/mhus-deploy:11.2
```

## Usage

In the directory 'build' is a list of projects, e.g. 'mhus-osgi-tools'. If you execute 
the script it will first execute 'mhus-lib' and others as dependency. The foirst time 
you execute the script, it will clone the repositories from github.

If you need to use another brunch first clone the repos and switch to another branch 
manually.

If you execute the scripts give the maven goals as parameters, e.g. 'mhus-lib install'. 

The script will compile only once until the source is changed. If you need to compile 
a single project or all again use the command deploy-retry [repo]. With deploy-status 
you can check the status of the existing repositories.

With 'deploy-status' you see also environment variable values. With the values you 
can control the deployment.

If you want to clean all 'mhus-sop' repositories execute:

```
deploy-retry
mhus-sop clean
```

If you get an error from maven and the execution stops you should set

```
export DEPLOY_MAVEN_NOT_QUIT=1
deploy-retry
mhus-sop clean
```

Don't forget to unset the variable!

## The container and sonar

To use the sonar java code analysis first start sonarqube

```
docker run -d --name sonarqube -p 9000:9000 sonarqube
```

Read the sonar documentation for detailed configuration: https://hub.docker.com/_/sonarqube

And now start the deploy container and link it to the sonar server:

```
docker run -it --name mhus-deploy \
 -h deploy-mhus \
 --link sonarqube:sonarserver \
 mhus/mhus-deploy:11.2
```

Now you can start sending your files to the server using maven, e.g. for mhus-sop:

```
mhus-sop sonar:sonar -Dsonar.host.url=http://sonarserver:9000
```


# Enhanced

## Remove
```
docker stop mhus-deploy
docker rm mhus-deploy
docker rmi mhus-deploy
```

## Extend

To add more deploy scripts you need to create your own Dockerfile and inherit this container image. Copy the additional build scripts in the build folder

```
FROM mhus/mhus-deploy

COPY build /home/user/build/

RUN set -x \
  && chown -R $APP_UID /home/user
```

## Push
```
docker push "mhus/mhus-deploy:11.2"
docker tag mhus/mhus-deploy:11.2 "mhus/mhus-deploy:latest"
docker push "mhus/mhus-deploy:latest"
```
