
# Deploy

## deploy first time
```
DATA=/mnt/storage/mhus

docker run -it --name mhus-deploy \
 -h deploy-mhus \
 -v $DATA/m2:/home/user/.m2 \
 -v $DATA/deploy:/home/user/deploy \
 mhus/mhus-deploy:1.0.2


DATA=~/tmp/mhus
mkdir -p $DATA

docker run -it --name mhus-deploy \
 -h deploy-mhus \
 -v ~/.m2:/home/user/.m2 \
 -v $DATA/deploy:/home/user/deploy \
 mhus/mhus-deploy:1.0.2
 
```

## start again
```
docker start -ai mhus-deploy
```

## Deploy

Start one of the scripts in build to deploy the specified package, e.g.

```
mhus-lib.sh
```

## Remove
```
docker stop mhus-deploy
docker rm mhus-deploy
docker rmi mhus-deploy
```

## Enhance

To add more deploy scripts you need to create your own Dockerfile and inherit this container image. Copy the additional build scripts in the build folder

```
FROM mhus/mhus-deploy
ARG APP_UID=501
COPY build /home/user/build/
USER 0
RUN set -x \
  && chown -R $APP_UID /home/user
USER $APP_UID
```

## Push
```
docker push "mhus/mhus-deploy:1.0.2"
docker tag mhus/mhus-deploy:1.0.2 "mhus/mhus-deploy:latest"
docker push "mhus/mhus-deploy:latest"
```
