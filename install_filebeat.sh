#!/usr/bin/env bash

version=6.1.2

rpm -ivh https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$version-x86_64.rpm
rpm -ivh https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-$version-x86_64.rpm

#filebeat模块的配置在/etc/filebeat/modules.d/
#https://www.elastic.co/guide/en/beats/filebeat/current/exported-fields.html
#https://www.elastic.co/guide/en/beats/filebeat/current/defining-processors.html
#参考 /etc/filebeat/filebeat.reference.yml
cp filebeat/filebeat.yaml /etc/filebeat/filebeat.yml

#metricbeat模块的配置在 /etc/metricbeat/modules.d
#https://www.elastic.co/guide/en/beats/metricbeat/current/exported-fields.html
#https://www.elastic.co/guide/en/beats/metricbeat/current/configuring-howto-metricbeat.html
#参考 /etc/metricbeat/metricbeat.reference.yml
cp filebeat/metricbeat.yml /etc/metricbeat/metricbeat.yml

filebeat setup --dashboards
filebeat setup --machine-learning
filebeat setup --template

metricbeat setup --dashboards
metricbeat setup --machine-learning
metricbeat setup --template

#匹配规则在 ll /usr/share/filebeat/module/*/*/ingest/*
#可根据特有日志格式修改对应的json

systemctl enable filebeat
systemctl start filebeat

systemctl enable metricbeat
systemctl start metricbeat