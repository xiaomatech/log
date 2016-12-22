#!/usr/bin/env bash

version=5.1.1

rpm -ivh https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$version.rpm
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
/usr/share/elasticsearch/bin/elasticsearch-plugin install lang-python
/usr/share/elasticsearch/bin/elasticsearch-plugin install --no-verify lukas-vlcek/bigdesk
/usr/share/elasticsearch/bin/elasticsearch-plugin install --no-verify lmenezes/elasticsearch-kopf
/usr/share/elasticsearch/bin/elasticsearch-plugin install elasticsearch/elasticsearch-repository-hdfs


systemctl start elasticsearch