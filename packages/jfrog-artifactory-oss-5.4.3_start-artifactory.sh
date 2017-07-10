#!/bin/bash

function uri_parser() {
    # URI capture
    uri="$@"

    # Safe escaping
    uri="${uri//\`/%60}"
    uri="${uri//\"/%22}"

    # Top level parsing
    pattern='^(([a-z]{3,5})://)?((([^:\/]+)(:([^@\/]*))?@)?([^:\/?]+)(:([0-9]+))?)(\/[^?]*)?(\?[^#]*)?(#.*)?$'
    [[ "$uri" =~ $pattern ]] || return 1;

    # Component extraction
    uri=${BASH_REMATCH[0]}
    uri_schema=${BASH_REMATCH[2]}
    uri_address=${BASH_REMATCH[3]}
    uri_user=${BASH_REMATCH[5]}
    uri_password=${BASH_REMATCH[7]}
    uri_host=${BASH_REMATCH[8]}
    uri_port=${BASH_REMATCH[10]}
    uri_path=${BASH_REMATCH[11]}
    uri_query=${BASH_REMATCH[12]}
    uri_fragment=${BASH_REMATCH[13]}

    # Path parsing
    count=0
    path="$uri_path"
    pattern='^/+([^/]+)'
    while [[ $path =~ $pattern ]]; do
        eval "uri_parts[$count]=\"${BASH_REMATCH[1]}\""
        path="${path:${#BASH_REMATCH[0]}}"
        let count++
    done

    # Query parsing
    count=0
    query="$uri_query"
    pattern='^[?&]+([^= ]+)(=([^&]*))?'
    while [[ $query =~ $pattern ]]; do
        eval "uri_args[$count]=\"${BASH_REMATCH[1]}\""
        eval "uri_arg_${BASH_REMATCH[1]}=\"${BASH_REMATCH[3]}\""
        query="${query:${#BASH_REMATCH[0]}}"
        let count++
    done

    # Return success
    return 0
}

# Configure database connections
if [ -n "${MYSQL_URI}" ]; then
  # Set up DB connection for MySQL; DB must be named artdb
  echo "Detected MySQL data service."
  cp $ARTIFACTORY_HOME/misc/db/mysql.properties $ARTIFACTORY_HOME/etc/db.properties
  echo "Parsing MYSQL URI and configurating DB connection..."
  uri_parser $MYSQL_URI
  uri_trimmed_path=$(echo ${uri_path} | cut -d/ -f 2)
  sed -i  -e "s/localhost/${uri_host}/g" \
          -e "s/3306/${uri_port}/g" \
          -e "s/artdb/${uri_trimmed_path}/g" \
          -e "s/=artifactory/=${uri_user}/g" \
          -e "s/=password/=${uri_password}/g" \
          $ARTIFACTORY_HOME/etc/db.properties
elif [ -n "${POSTGRES_URI}" ]; then
  # Set up DB connection for Postgres; DB must be named "artifactory"
  echo "Detected PostgreSQL data service."
  cp $ARTIFACTORY_HOME/misc/db/postgresql.properties $ARTIFACTORY_HOME/etc/db.properties
  echo "Parsing POSTGRES URI and configurating DB connection..."
  uri_parser $POSTGRES_URI
  uri_trimmed_path=$(echo ${uri_path} | cut -d/ -f 2)
  sed -i  -e "s/localhost/${uri_host}/g" \
          -e "s/5432/${uri_port}/g" \
          -e "s/\/artifactory/\/${uri_trimmed_path}/g" \
          -e "s/=artifactory/=${uri_user}/g" \
          -r "s/=password/=${uri_password}/g" \
          $ARTIFACTORY_HOME/etc/db.properties
else
  echo "Using embedded Derby database..."
fi


# Configuring the Artifactory Access Client
#echo 'artifactory.access.client.serverUrl.override=http://127.0.0.1:8081/access' >> $ARTIFACTORY_HOME/etc/artifactory.system.properties
#echo 'artifactory.access.server.bundled=true' >> $ARTIFACTORY_HOME/etc/artifactory.system.properties


# Start Artifactory and tail key log files
$ARTIFACTORY_HOME/bin/artifactoryctl start \
  && echo 'Starting JFrog Artifactory...' \
  && sleep 10 && echo 'Tailing logs...' \
  && tail -f -n 500 $ARTIFACTORY_HOME/logs/*.*
