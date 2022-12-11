#!/usr/bin/env bash

function gen_hash() {
  return "$(date +%s)" | sha256sum | cut -c1-7
}

IMAGE_NAME=xanonymous/gtest-cpp-essential-env

docker builder prune -f -a
docker build --pull \
  -t $IMAGE_NAME \
  -t $IMAGE_NAME:"$(gen_hash)" \
  . &&
  docker push $IMAGE_NAME --all-tags
