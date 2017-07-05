#!/bin/bash

# TODO: Add xpack support
#pack_url="https://artifacts.elastic.co/downloads/logstash-plugins"
#if $LS_XPACK_ENABLED; then
#  LOGSTASH_PACK_URL=$pack_url $LS_HOME/bin/logstash-plugin install xpack
#fi

$LS_HOME/bin/logstash -f $LS_HOME/pipeline/logstash-5.4.1-$LS_PIPELINE.conf
