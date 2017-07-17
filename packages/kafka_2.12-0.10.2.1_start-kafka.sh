#!/bin/bash


# Check for required settings
if [[ -z "$KAFKA_ADVERTISED_LISTENERS" || -z "$KAFKA_ZOOKEEPER_CONNECT" ]]; then
    echo "Kafka package requires Zookeeper and Advertised Listeners"
    echo "Required settings not found."
    echo "-- Please set KAFKA_ADVERTISED_LISTENERS and KAFKA_ZOOKEEPER_CONNECT"
    echo "KAFKA_ADVERTISED_LISTENERS  = ${KAFKA_ADVERTISED_LISTENERS}"
    echo "KAFKA_ZOOKEEPER_CONNECT     = ${KAFKA_ZOOKEEPER_CONNECT}"
    exit 1
fi

# Configure Kafka's broker ID
# Check to see if Broker ID is provided via env var. If not, check to see
# if a custom command is provided to derive the Broker ID. Lastly, if neither
# exists, then auto-generate the Broker ID.
if [[ -z "$KAFKA_BROKER_ID" ]]; then
    if [[ -n "$BROKER_ID_COMMAND" ]]; then
        export KAFKA_BROKER_ID=$(eval $BROKER_ID_COMMAND)
    else
        # By default auto allocate broker ID
        export KAFKA_BROKER_ID=-1
    fi
fi

# Check or set directory to write Kafka logs to mountpath of persistent filesystem
if [[ -z "$KAFKA_LOG_DIRS" ]]; then
    export KAFKA_LOG_DIRS=$KAFKA_HOME/logs
fi

# Set Kafka's heap options
if [[ -n "$KAFKA_HEAP_OPTS" ]]; then
    sed -r -i "s/(export KAFKA_HEAP_OPTS)=\"(.*)\"/\1=\"$KAFKA_HEAP_OPTS\"/g" $KAFKA_HOME/bin/kafka-server-start.sh
    unset KAFKA_HEAP_OPTS
fi

# Update Kafka runtime properties with env var values.
# Note that no config values may contain an '@' char
for VAR in `env`
do
  if [[ $VAR =~ ^KAFKA_ && ! $VAR =~ ^KAFKA_HOME ]]; then
    kafka_name=`echo "$VAR" | sed -r "s/KAFKA_(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]' | tr _ .`
    env_var=`echo "$VAR" | sed -r "s/(.*)=.*/\1/g"`
    if egrep -q "(^|^#)$kafka_name=" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s@(^|^#)($kafka_name)=(.*)@\2=${!env_var}@g" $KAFKA_HOME/config/server.properties
    else
        echo "$kafka_name=${!env_var}" >> $KAFKA_HOME/config/server.properties
    fi
  fi
done

if [[ -n "$CUSTOM_INIT_SCRIPT" ]] ; then
  eval $CUSTOM_INIT_SCRIPT
fi

# Print for advanced configuration settings passed via env var
echo "Required settings:"
echo "------------------"
echo "KAFKA_ADVERTISED_LISTENERS  = ${KAFKA_ADVERTISED_LISTENERS}"
echo "KAFKA_ZOOKEEPER_CONNECT     = ${KAFKA_ZOOKEEPER_CONNECT}"
echo "Advanced configuration settings:"
echo "--------------------------------"
echo "GC_LOG_ENABLED              = ${GC_LOG_ENABLED}"
echo "KAFKA_GC_LOG_OPTS           = ${KAFKA_GC_LOG_OPTS}"
echo "KAFKA_JVM_PERFORMANCE_OPTS  = ${KAFKA_JVM_PERFORMANCE_OPTS}"
echo "KAFKA_HEAP_OPTS             = ${KAFKA_HEAP_OPTS}"
echo "KAFKA_OPTS                  = ${KAFKA_OPTS}"
echo "KAFKA_LOG4J_OPTS            = ${KAFKA_LOG4J_OPTS}"
echo "LOG_DIRS                    = ${LOG_DIRS}"
echo "JMX_PORT                    = ${JMX_PORT}"
echo "KAFKA_JMX_OPTS              = ${KAFKA_JMX_OPTS}"

# TODO: Add support for automatically creating topics
#$KAFKA_HOME/custom_scripts/create-topics.sh &

$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
