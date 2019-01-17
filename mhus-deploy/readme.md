
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
