#!/usr/bin/env bash

function gen_hash() {
  return "$(date +%s)" | sha256sum | cut -c1-7
}

IMAGE_NAME=xanonymous/gtest-cpp-essential-env

set -e

# create a temporary builder
docker buildx create --name tmp_getstrin_builder --use

# pull all tags from remote.
docker pull --all-tags $IMAGE_NAME

# build the image.
docker buildx build \
  -t ${IMAGE_NAME}:latest \
  -t ${IMAGE_NAME}:"$(gen_hash)" \
  --push .

# remove the temporary builder
docker buildx rm tmp_getstrin_builder -f
