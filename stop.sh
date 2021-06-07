#!/bin/bash

docker stop fluentd-jenkins-exporter
docker rm -f fluentd-jenkins-exporter

exit 0
