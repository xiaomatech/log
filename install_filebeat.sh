#!/usr/bin/env bash

version=6.1.1

rpm -ivh https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$version-x86_64.rpm
rpm -ivh https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-$version-x86_64.rpm

systemctl start filebeat
systemctl start metricbeat