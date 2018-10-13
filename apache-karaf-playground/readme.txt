
./create.sh

docker tag apache-karaf-playground "mhus/apache-karaf-playground:4.0.10"
docker tag apache-karaf-playground "mhus/apache-karaf-playground:latest"

docker push "mhus/apache-karaf-playground:4.0.10"
docker push "mhus/apache-karaf-playground:latest"

Start

