#!/bin/bash

set -euxo pipefail

REGISTRY=<docker-registry>
REPO=<docker-repo>
TAG=${1-latest}

# Build Image
docker build -t ${REPO}:${TAG} .

docker tag ${REPO}:${TAG} ${REGISTRY}/${REPO}:${TAG}
docker push ${REGISTRY}/${REPO}:${TAG}
