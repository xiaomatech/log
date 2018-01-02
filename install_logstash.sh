#!/usr/bin/env bash

version=6.1.1

rpm -ivh https://artifacts.elastic.co/downloads/logstash/logstash-$version.rpm
/usr/share/logstash/bin/logstash-plugin install --no-verify ./logstash-filter-referer-1.0.0.gem
/usr/share/logstash/bin/logstash-plugin install --no-verify ./logstash-filter-ipip-2.0.0.gem
sudo yum install -y GeoIP-data
mkdir -p /data/logs/logstash

echo -e "LOGSTASH_HOME=/usr/share/logstash\nJRUBY_HOME=$LOGSTASH_HOME/vendor/jruby">/etc/profile.d/logstash

source /etc/profile.d/logstash

$JRUBY_HOME/bin/jruby -S $JRUBY_HOME/bin/gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/

cp -r ./logstash/* /etc/logstash/

systemctl start logstash
