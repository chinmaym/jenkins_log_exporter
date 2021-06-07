#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -f "${SCRIPT_DIR}/elasticsearch_details.txt" ]; then
  source ${SCRIPT_DIR}/elasticsearch_details.txt
else
  printf "ERROR! elasticsearch_details.txt is missing\n"
  exit 1
fi

if [[ -z "${ELASTICSEARCH_HOST}" ]] || [[ -z "${ELASTICSEARCH_PORT}" ]] || \
    [[ -z "${ELASTICSEARCH_USER}" ]] || [[ -z "${ELASTICSEARCH_PASSWORD}" ]]
then
  printf "ERROR! Could not find on the of the following in the environment.
  ELASTICSEARCH_HOST, ELASTICSEARCH_PORT, ELASTICSEARCH_USER, ELASTICSEARCH_PASSWORD. \n"
  exit 1
fi

docker run --cpus="1" --memory="256mb" -d \
        -e ELASTICSEARCH_HOST="${ELASTICSEARCH_HOST}" \
        -e ELASTICSEARCH_PORT="${ELASTICSEARCH_PORT}" \
        -e ELASTICSEARCH_USER="${ELASTICSEARCH_USER}" \
        -e ELASTICSEARCH_PASSWORD="${ELASTICSEARCH_PASSWORD}" \
        -p 9234:9234 \
        --name fluentd-jenkins-exporter \
        <docker-registry>/log-exporter:latest # replace <docker-registry> with your own docker-registry or change the line with a local image name.
