# Set up runtime environment 
export AGENT_WORK_DIR=$GO_AGENT_HOME/agent_work_dir
export DAEMON=N

# Run GoCD Server
cd $GO_SERVER_HOME
./server.sh
