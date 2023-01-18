#!/bin/bash

gcloud container clusters get-credentials pvs-devops-iac-gke --zone us-south1-c --project pvs-devops-iac
kubectl create ns jenkins
helm install ingress ingress-nginx/ingress-nginx -n jenkins
helm show values jenkins/jenkins > jenkins.yaml
helm install jenkins jenkins/jenkins --values jenkins.yaml -n jenkins
kubectl apply -f ingress.yaml
# kubectl create clusterrolebinding jenkins --clusterrole cluster-admin --serviceaccount=jenkins:default
