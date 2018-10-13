
./create.sh

docker tag apache-playground-karaf "mhus/apache-playground-karaf:4.0.10"
docker tag apache-playground-karaf "mhus/apache-playground-karaf:latest"

docker push "mhus/apache-playground-karaf:4.0.10"
docker push "mhus/apache-playground-karaf:latest"

