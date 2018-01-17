#!/usr/bin/env bash

version=6.1.1

rpm -ivh https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$version.rpm
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-user-agent
/usr/share/elasticsearch/bin/elasticsearch-plugin install x-pack
/usr/share/elasticsearch/bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v$version/elasticsearch-analysis-ik-$version.zip
/usr/share/elasticsearch/bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v$version/elasticsearch-analysis-pinyin-$version.zip

pip install -U elasticsearch-curator

#https://github.com/o19s/elasticsearch-learning-to-rank

cp es_jvm.options /etc/elasticsearch/jvm.options

mkdir -p /etc/sysctl.d
echo "vm.max_map_count=262144" > /etc/sysctl.d/11-es.conf
echo -ne '* soft nproc 8192 \nelasticsearch  -  nofile  65536' > /etc/security/limits.d/es.conf

echo -ne '''
ES_HOME=/usr/share/elasticsearch/

ES_HEAP_SIZE=128m
MAX_OPEN_FILES=65535
MAX_MAP_COUNT=262144
LOG_DIR=/var/log/elasticsearch
WORK_DIR=/tmp/elasticsearch/
CONF_DIR=/etc/elasticsearch/
ES_PATH_CONF=/etc/elasticsearch/
RESTART_ON_UPGRADE=true
PID_DIR=/var/run/elasticsearch
JAVA_HOME=/usr/java/default
ES_STARTUP_SLEEP_TIME=5
ES_JAVA_OPTS="-verbose:gc -Xloggc:/var/log/elasticsearch/elasticsearch_gc.log -XX:-CMSConcurrentMTEnabled \
-XX:+PrintGCDateStamps -XX:+PrintGCDetails -XX:+PrintGCTimeStamps \
-XX:ErrorFile=/var/log/elasticsearch/elasticsearch_err.log -XX:ParallelGCThreads=8"
MAX_LOCKED_MEMORY=unlimited
MAX_MAP_COUNT=262144
'''> /etc/sysconfig/elasticsearch

sudo swapoff -a

systemctl start elasticsearch
