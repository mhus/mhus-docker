
# Deploy

## deploy first time
```
DATA=/mnt/storage/mhus

docker run -it --name mhus-deploy \
 -h deploy-mhus \
 -v $DATA/m2:/home/user/.m2 \
 -v $DATA/deploy:/home/user/deploy \
 mhus-deploy
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
COPY build /home/user/build/
```

## Push
```
docker tag mhus-deploy "mhus/mhus-deploy:1.0.0"
docker tag mhus-deploy "mhus/mhus-deploy:latest"

docker push "mhus/mhus-deploy:1.0.0"
docker push "mhus/mhus-deploy:latest"
```
