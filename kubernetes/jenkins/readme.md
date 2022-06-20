
helm repo add jenkins https://charts.jenkins.io
helm repo update

kubectl create ns jenkins
k apply -f volume.yaml 

helm install jenkins jenkins/jenkins -f values.yaml

kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password


