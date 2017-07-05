#!/bin/bash

# Run Kibana, using environment variables to set longopts defining Kibana's
# configuration.
#
# eg. Setting the environment variable:
#
#       ELASTICSEARCH_STARTUPTIMEOUT=60
#
# will cause Kibana to be invoked with:
#
#       --elasticsearch.startupTimeout=60

kibana_vars=(
    console.enabled
    console.proxyConfig
    console.proxyFilter
    elasticsearch.customHeaders
    elasticsearch.password
    elasticsearch.pingTimeout
    elasticsearch.preserveHost
    elasticsearch.requestHeadersWhitelist
    elasticsearch.requestTimeout
    elasticsearch.shardTimeout
    elasticsearch.ssl.ca
    elasticsearch.ssl.cert
    elasticsearch.ssl.certificate
    elasticsearch.ssl.certificateAuthorities
    elasticsearch.ssl.key
    elasticsearch.ssl.keyPassphrase
    elasticsearch.ssl.verificationMode
    elasticsearch.ssl.verify
    elasticsearch.startupTimeout
    elasticsearch.tribe.customHeaders
    elasticsearch.tribe.password
    elasticsearch.tribe.pingTimeout
    elasticsearch.tribe.requestHeadersWhitelist
    elasticsearch.tribe.requestTimeout
    elasticsearch.tribe.ssl.ca
    elasticsearch.tribe.ssl.cert
    elasticsearch.tribe.ssl.certificate
    elasticsearch.tribe.ssl.certificateAuthorities
    elasticsearch.tribe.ssl.key
    elasticsearch.tribe.ssl.keyPassphrase
    elasticsearch.tribe.ssl.verificationMode
    elasticsearch.tribe.ssl.verify
    elasticsearch.tribe.url
    elasticsearch.tribe.username
    elasticsearch.url
    elasticsearch.username
    kibana.defaultAppId
    kibana.index
    logging.dest
    logging.quiet
    logging.silent
    logging.verbose
    ops.interval
    pid.file
    server.basePath
    server.defaultRoute
    server.host
    server.maxPayloadBytes
    server.name
    server.port
    server.ssl.cert
    server.ssl.certificate
    server.ssl.certificateAuthorities
    server.ssl.cipherSuites
    server.ssl.clientAuthentication
    server.ssl.enabled
    server.ssl.key
    server.ssl.keyPassphrase
    server.ssl.supportedProtocols
    status.allowAnonymous
    status.v6ApiFormat
    tilemap.options.attribution
    tilemap.options.maxZoom
    tilemap.options.minZoom
    tilemap.options.subdomains
    tilemap.url
    xpack.graph.enabled
    xpack.ml.enabled
    xpack.monitoring.elasticsearch.password
    xpack.monitoring.elasticsearch.url
    xpack.monitoring.elasticsearch.username
    xpack.monitoring.enabled
    xpack.monitoring.kibana.collection.enabled
    xpack.monitoring.kibana.collection.interval
    xpack.monitoring.max_bucket_size
    xpack.monitoring.min_interval_seconds
    xpack.monitoring.node_resolver
    xpack.monitoring.report_stats
    xpack.monitoring.ui.container.elasticsearch.enabled
    xpack.reporting.capture.concurrency
    xpack.reporting.capture.loadDelay
    xpack.reporting.capture.settleTime
    xpack.reporting.capture.timeout
    xpack.reporting.enabled
    xpack.reporting.encryptionKey
    xpack.reporting.kibanaApp
    xpack.reporting.kibanaServer.hostname
    xpack.reporting.kibanaServer.port
    xpack.reporting.kibanaServer.protocol
    xpack.reporting.queue.indexInterval
    xpack.reporting.queue.pollInterval
    xpack.reporting.queue.timeout
    xpack.security.cookieName
    xpack.security.enabled
    xpack.security.encryptionKey
    xpack.security.secureCookies
    xpack.security.sessionTimeout
)

longopts=''
for kibana_var in ${kibana_vars[*]}; do
    # 'elasticsearch.url' -> 'ELASTICSEARCH_URL'
    env_var=$(echo ${kibana_var^^} | tr . _)

    # Indirectly lookup env var values via the name of the var.
    # REF: http://tldp.org/LDP/abs/html/bashver2.html#EX78
    value=${!env_var}
    if [[ -n $value ]]; then
      longopt="--${kibana_var}=${value}"
      longopts+=" ${longopt}"
    fi
done

# TODO: Add support for xpack
#if $KIBANA_XPACK_ENABLED; then
#  $KIBANA_HOME/bin/kibana-plugin install x-pack
#fi

# The virtual file /proc/self/cgroup should list the current cgroup
# membership. For each hierarchy, you can follow the cgroup path from
# this file to the cgroup filesystem (usually /sys/fs/cgroup/) and
# introspect the statistics for the cgroup for the given
# hierarchy. Alas, Docker breaks this by mounting the container
# statistics at the root while leaving the cgroup paths as the actual
# paths. Therefore, Kibana provides a mechanism to override
# reading the cgroup path from /proc/self/cgroup and instead uses the
# cgroup path defined the configuration properties
# cpu.cgroup.path.override and cpuacct.cgroup.path.override.
# Therefore, we set this value here so that cgroup statistics are
# available for the container this process will run in.

# exec $KIBANA_HOME/bin/kibana --cpu.cgroup.path.override=/ --cpuacct.cgroup.path.override=/ ${longopts}

exec $KIBANA_HOME/bin/kibana ${longopts}
