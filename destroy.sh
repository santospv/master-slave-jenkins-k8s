#!/bin/bash

helm unistall jenkins -n jenkins
helm unistall ingress -n jenkins
kubectl delete secrets regcred -n jenkins
kubectl delete -f /app