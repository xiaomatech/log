#!/usr/bin/env bash

version=6.1.1

rpm -ivh https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$version.rpm
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-user-agent
/usr/share/elasticsearch/bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v$version/elasticsearch-analysis-ik-$version.zip
/usr/share/elasticsearch/bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v$version/elasticsearch-analysis-pinyin-$version.zip

#https://github.com/o19s/elasticsearch-learning-to-rank

systemctl start elasticsearch
