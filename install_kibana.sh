#!/usr/bin/env bash

yum install -y fontconfig freetype
version=6.1.1

rpm -ivh https://artifacts.elastic.co/downloads/kibana/kibana-$version-x86_64.rpm
/usr/share/kibana/bin/kibana-plugin install https://github.com/elasticfence/kaae/releases/download/snapshot/kaae-latest.tar.gz
/usr/share/kibana/bin/kibana-plugin install https://github.com/sivasamyk/logtrail/releases/download/0.1.6/logtrail-5.x-0.1.6.zip


systemctl start kibana