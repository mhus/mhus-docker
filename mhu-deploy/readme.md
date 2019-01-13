
# Deploy

## deploy first time
```
docker run -it --name mhus-deploy \
 -h deploy-mhus \
 -v /mnt/storage/mhus/m2:/root/.m2 \
 -v /mnt/storage/mhus/deploy:/deploy \
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
