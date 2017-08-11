# Set up runtime environment
export SERVER_MEM=512m
export SERVER_MAX_MEM=${MEM_ALLOC:=1024m}
export GO_SERVER_PORT=$PORT
export SERVER_WORK_DIR=$GO_SERVER_HOME/server_work_dir

# Run GoCD Server
cd $GO_SERVER_HOME
./server.sh
