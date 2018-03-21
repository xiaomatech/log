#!/usr/bin/env bash

version=6.2.3

rpm -ivh https://artifacts.elastic.co/downloads/logstash/logstash-$version.rpm
/usr/share/logstash/bin/logstash-plugin install logstash-output-opentsdb
/usr/share/logstash/bin/logstash-plugin install --no-verify https://raw.githubusercontent.com/xiaomatech/logstash-filter-ipip/master/logstash-filter-ipip-2.0.0.gem
/usr/share/logstash/bin/logstash-plugin install --no-verify https://raw.githubusercontent.com/xiaomatech/logstash-filter-referer/master/referer-parser-0.3.0.gem
/usr/share/logstash/bin/logstash-plugin install --no-verify https://raw.githubusercontent.com/xiaomatech/logstash-filter-referer/master/logstash-filter-referer-1.0.0.gem
/usr/share/logstash/bin/logstash-plugin install --no-verify https://raw.githubusercontent.com/xiaomatech/logstash-filter-redis/master/logstash-filter-redis-1.0.0.gem

wget https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-$version.zip -O /tmp/x-pack-$version.zip

/usr/share/logstash/bin/logstash-plugin install -O /tmp/x-pack-$version.zip

sudo yum install -y GeoIP-data
mkdir -p /data/logs/logstash

mkdir -p /etc/logstash/patterns
/bin/cp -rf /usr/share/logstash/vendor/bundle/jruby/*/gems/logstash-patterns-core-*/patterns/* /etc/logstash/patterns/

echo -ne "LOGSTASH_HOME=/usr/share/logstash\nJRUBY_HOME=\$LOGSTASH_HOME/vendor/jruby">/etc/profile.d/logstash
source /etc/profile.d/logstash

/usr/share/logstash/vendor/jruby/bin/jruby -S /usr/share/logstash/vendor/jruby/bin/gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/

nproc=$[`nproc`*2 -1]
cp -r ./logstash/* /etc/logstash/

echo -ne '''
JAVACMD=/usr/bin/java
LS_HOME=/usr/share/logstash
LS_SETTINGS_DIR=/etc/logstash
LS_OPTS="--path.settings ${LS_SETTINGS_DIR}"
LS_JAVA_OPTS=""
LS_USER=logstash
LS_GROUP=logstash
LS_PIDFILE=/var/run/logstash.pid
LS_GC_LOG_FILE=/var/log/logstash/gc.log
LS_OPEN_FILES=65536
LS_NICE=19
SERVICE_NAME="logstash"
SERVICE_DESCRIPTION="logstash"
LS_HEAP_SIZE=8g
''' > /etc/logstash/startup.options

echo -ne '''
path.data: /var/lib/logstash
dead_letter_queue.enable: true
path.dead_letter_queue: /var/lib/logstash/dead_letter_queue
path.config: /etc/logstash/conf.d/*.conf
path.logs: /var/log/logstash
pipeline.workers: '''$nproc'''
pipeline.output.workers: '''$nproc'''
pipeline.batch.size: 2000
pipeline.batch.delay: 3
queue.page_capacity: 256mb
queue.max_bytes: 8gb
queue.drain: true
queue.type: memory
slowlog.threshold.warn: 2s
slowlog.threshold.info: 1s
slowlog.threshold.debug: 500ms
slowlog.threshold.trace: 100ms
config.reload.automatic: true

xpack.security.enabled: false
xpack.monitoring.elasticsearch.username: test
xpack.monitoring.elasticsearch.password: test

'''> /etc/logstash/logstash.yml

systemctl enable logstash
systemctl start logstash
