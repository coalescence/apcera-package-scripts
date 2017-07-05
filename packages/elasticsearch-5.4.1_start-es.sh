#!/bin/bash

#TODO: Add support for the xpack plugin
for plugin in ingest-user-agent ingest-geoip; do
  $ES_HOME/bin/elasticsearch-plugin install --batch $plugin
done

$ES_HOME/bin/elasticsearch
