# mhus-docker

Useful docker files e.g. as stages for other applications

docker build -t apache-karaf apache-karaf

docker tag apache-karaf "mhus/apache-karaf:4.0.10"
docker tag apache-karaf "mhus/apache-karaf:latest"

docker push "mhus/apache-karaf:4.0.10"
docker push "mhus/apache-karaf:latest"

---

https://lostechies.com/gabrielschenker/2016/09/26/use-docker-to-build-test-and-push-your-artifacts/

