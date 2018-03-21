#!/usr/bin/env bash

version=6.2.3

yum install -y fontconfig freetype

rpm -ivh https://artifacts.elastic.co/downloads/kibana/kibana-$version-x86_64.rpm
/usr/share/kibana/bin/kibana-plugin install https://github.com/elasticfence/kaae/releases/download/snapshot/kaae-latest.tar.gz
/usr/share/kibana/bin/kibana-plugin install https://github.com/sivasamyk/logtrail/releases/download/0.1.6/logtrail-5.x-0.1.6.zip
wget https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-$version.zip -O /tmp/x-pack-$version.zip
/usr/share/kibana/bin/kibana-plugin install /tmp/x-pack-$version.zip


echo -ne '''
xpack.security.enabled: false
elasticsearch.username: test
elasticsearch.password: test
'''>/etc/kibana/kibana.yaml

systemctl enable kibana
systemctl start kibana