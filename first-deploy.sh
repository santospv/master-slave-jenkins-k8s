#!/bin/bash

kubectl create namespace jenkins
chmod +x secret-docker.sh
./secret-docker.sh
helm install ingress ingress-nginx/ingress-nginx -n jenkins
helm install jenkins jenkins/jenkins --values jenkins/jenkins.yaml -n jenkins
kubectl apply -f jenkins/ingress.yaml
#kubectl apply -f app/
