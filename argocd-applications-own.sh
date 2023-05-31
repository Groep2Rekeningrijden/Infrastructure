#!/usr/bin/env bash

set -e

# FUNCTIONS

deploy(){
  kubectl apply -n argocd -f ArgoCD/$1.yaml

  kubectl delete secret -A -l owner=helm,name=$1
}

# RUN

deploy repo
deploy rabbitmq
deploy car-service
deploy coordinate-service
deploy router-api