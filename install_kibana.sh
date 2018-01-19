#!/usr/bin/env bash

version=6.1.2

yum install -y fontconfig freetype

rpm -ivh https://artifacts.elastic.co/downloads/kibana/kibana-$version-x86_64.rpm
/usr/share/kibana/bin/kibana-plugin install https://github.com/elasticfence/kaae/releases/download/snapshot/kaae-latest.tar.gz
/usr/share/kibana/bin/kibana-plugin install https://github.com/sivasamyk/logtrail/releases/download/0.1.6/logtrail-5.x-0.1.6.zip
#/usr/share/kibana/bin/kibana-plugin install x-pack

systemctl enable kibana
systemctl start kibana