
./create.sh

docker tag apache-karaf "mhus/apache-karaf:4.0.10"
docker tag apache-karaf "mhus/apache-karaf:latest"

docker push "mhus/apache-karaf:4.0.10"
docker push "mhus/apache-karaf:latest"

== Start karaf

docker run -it --name karaf apache-karaf

see apache-karaf-playground for more options
