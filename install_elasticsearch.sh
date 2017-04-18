#!/usr/bin/env bash

version=5.1.1

rpm -ivh https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$version.rpm
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
/usr/share/elasticsearch/bin/elasticsearch-plugin install repository-hdfs
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-user-agent
/usr/share/elasticsearch/bin/elasticsearch-plugin install lang-python
/usr/share/elasticsearch/bin/elasticsearch-plugin install --no-verify lukas-vlcek/bigdesk
/usr/share/elasticsearch/bin/elasticsearch-plugin install --no-verify lmenezes/elasticsearch-kopf

/usr/share/elasticsearch/bin/elasticsearch-plugin install --no-verify https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v1.10.3/elasticsearch-analysis-ik-1.10.3.zip
/usr/share/elasticsearch/bin/elasticsearch-plugin install --no-verify https://github.com/NLPchina/elasticsearch-sql/releases/download/5.1.2.0/elasticsearch-sql-5.1.2.0.zip

systemctl start elasticsearch
