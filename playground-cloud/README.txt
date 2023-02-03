

kubectl run playground --image mhus/playground-cloud --rm -it

docker run --rm -it --name playground mhus/playground-cloud


kubectl run playground --image mhus/playground-cloud -- -c "sleep 1d"

docker run -d -it --name playground mhus/playground-cloud
