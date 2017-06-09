#!/bin/bash

# Configure config files with sane values
sed -i -r 's|#(log4j.appender.ROLLINGFILE.MaxBackupIndex.*)|\1|g' $ZK_HOME/conf/log4j.properties
sed -i -r 's|#autopurge|autopurge|g' $ZK_HOME/conf/zoo.cfg

# Configure clustering
if [ $ZK_CLUSTERED = true ]; then
  node=`echo -n $CNTM_JOB_FQN | cut -d: -f 5`
  node_num=${$node: -1}
  echo $node_num > $ZK_HOME/data/myid
  for x in `seq ${ZK_CLUSTER_SIZE}`; do
    echo "server.${x}=zookeeper-node${x}.apcera.local:2888:3888" >> $ZK_HOME/conf/zoo.cfg
  done
fi

$ZK_HOME/bin/zkServer.sh start-foreground
