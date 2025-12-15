#!/bin/bash
set -x

export GHCR_PAT="$(cat)"

kubectl create secret docker-registry ghcr-secret \
  --docker-server=ghcr.io \
  --docker-username=gmbenz \
  --docker-password=$GHCR_PAT \
  --docker-email=you@example.com

kubectl apply -f deploy-producer.yaml
kubectl apply -f deploy-consumer.yaml

kubectl logs job/rabbit-producer
kubectl logs deploy/rabbit-consumer
