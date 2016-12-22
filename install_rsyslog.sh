#!/usr/bin/env bash

yum install -y rsyslog-kafka rsyslog-mmjsonparse rsyslog-mmnormalize rsyslog-mmfields rsyslog-mmanon rsyslog-elasticsearch

systemctl start rsyslog
