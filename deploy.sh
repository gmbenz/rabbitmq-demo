#!/bin/bash
set -x

export GHCR_PAT=""

kubectl create secret docker-registry ghcr-secret \
  --docker-server=ghcr.io \
  --docker-username=gmbenz \
  --docker-password=$GHCR_PAT \
  --docker-email=you@example.com

kubectl apply -f producer.yaml
kubectl apply -f consumer.yaml

kubectl logs deploy/rabbit-producer
kubectl logs deploy/rabbit-consumer
