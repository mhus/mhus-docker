## Features

* see apache-karaf-playground for details
* Run as user 501 by default

## Create Image
```
./create.sh

docker tag apache-karaf "mhus/apache-karaf:4.2.1"
docker tag apache-karaf "mhus/apache-karaf:latest"

docker push "mhus/apache-karaf:4.2.1"
docker push "mhus/apache-karaf:latest"
```

Options:

* Build argument KARAF_UID

## Start karaf
```
docker run -it --name karaf apache-karaf
```

see apache-karaf-playground for more options
