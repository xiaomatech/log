#!/usr/bin/env bash

yum install -y rsyslog-kafka rsyslog-mmjsonparse rsyslog-mmnormalize rsyslog-mmfields rsyslog-mmanon rsyslog-elasticsearch

cp  ./rsyslog.conf /etc/
cp -r  ./rsyslog.d /etc/

rpm -ivh ./rsyslog-mmgrok-hdfs-8.23.0-1.x86_64.rpm

systemctl start rsyslog
