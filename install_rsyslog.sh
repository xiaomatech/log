#!/usr/bin/env bash

yum install -y rsyslog-kafka rsyslog-mmjsonparse rsyslog-mmnormalize rsyslog-mmfields rsyslog-mmanon

mkdir -p /data/rsyslog
/bin/cp  ./rsyslog.conf /etc/
/bin/cp -rf  ./rsyslog.d /etc/

systemctl start rsyslog
