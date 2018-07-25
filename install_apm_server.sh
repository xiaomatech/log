#!/usr/bin/env bash

version=6.3.2

rpm -ivh https://artifacts.elastic.co/downloads/apm-server/apm-server-$version-x86_64.rpm

echo -ne '''
apm-server:
  host: "localhost:8200"
  frontend:
    enabled: true

setup.template.enabled: true
setup.template.settings:
  index:
    number_of_shards: 16
    codec: best_compression

setup.kibana:
  host: "localhost:5601"

output.elasticsearch:
  hosts: ["ElasticsearchAddress:9200"]
  worker: 8
  bulk_max_size: 5120
  username: "elastic"
  password: "elastic"
  indices:
    - index: "apm-%{[beat.version]}-sourcemap"
      when.contains:
        processor.event: "sourcemap"

    - index: "apm-%{[beat.version]}-error-%{+yyyy.MM.dd}"
      when.contains:
        processor.event: "error"

    - index: "apm-%{[beat.version]}-transaction-%{+yyyy.MM.dd}"
      when.contains:
        processor.event: "transaction"

    - index: "apm-%{[beat.version]}-span-%{+yyyy.MM.dd}"
      when.contains:
        processor.event: "span"

path.data: /data/apm-server
path.logs: /data/logs/apm-server

setup.dashboards.enabled: true

http.enabled: true
'''>/etc/apm-server/apm-server.yml

systemctl enable apm-server
systemctl start apm-server
