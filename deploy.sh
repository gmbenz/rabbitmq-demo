#!/bin/bash
set -x

if [ -z "$GHCR_PAT" ]; then
   export GHCR_PAT="$(cat)"
   kubectl create secret docker-registry ghcr-secret \
     --docker-server=ghcr.io \
     --docker-username=gmbenz \
     --docker-password=$GHCR_PAT \
     --docker-email=you@example.com
fi

kubectl apply -f job-producer.yaml
kubectl apply -f deploy-consumer.yaml

kubectl logs job/rabbit-producer
kubectl logs deploy/rabbit-consumer
