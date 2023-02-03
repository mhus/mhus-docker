

kubectl run playground --image mhus/playground-pod --rm -it

docker run --rm -it --name playground mhus/playground-pod


kubectl run playground --image mhus/playground-pod -- -c "sleep 1d"

docker run -d -it --name playground mhus/playground-pod
