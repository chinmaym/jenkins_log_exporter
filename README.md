# Jenkins Log Exporter

## Steps to export jenkins job logs

### Changes to jenkins
Logstash plugin (https://plugins.jenkins.io/logstash/)

    > This plugin has to be installed in jenkins to be able to ship all the job logs to a fluentd container.

Details for the logstash plugin, username and plugin should be left blank. The URI field should contain the IP and port of the fluentd service running inside the container. Fluentd is configured to listen on port 9234. Therefore, the value of URI should be `http://localhost:9234/jenkins_log`. This will enable all the jobs to ship the logs to the fluentd container running on the same jenkins machine.

### Fluentd container setup
After cloning the repo, create a file called `elasticsearch_details.txt` with the following details for the elasticsearch instance in the jenkins-log-exporter folder, fluentd will use this information to connect to the elasticsearch instance.

1. Command to start the fluentd_exporter
```sh
./start.sh
```
2. Stop the container
```
./stop.sh
```
