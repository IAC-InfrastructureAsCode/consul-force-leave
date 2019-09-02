#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  CONSUL FORCE LEAVE - CRON WEEKLY
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  License    : Apache version 2.0
# -----------------------------------------------------------------------------

export CONSUL_SERVER="http://DNS-OR-IP-CONSUL-SERVER:8500"
export PATH_LOG="/var/log/consul-force-leave"
export PATH_DIR="weekly"
export PATH_LOG_CONSUL=$PATH_LOG"/"$PATH_DIR

export SNAPSHOT_LOG="week-"$(date +%V)
export LOG_FILE=$PATH_LOG_CONSUL"/"$SNAPSHOT_LOG.log

run_check_members(){
  echo "Get All failed node from consul members"
  export MEMBERS=`consul members -http-addr=$CONSUL_SERVER | grep failed`
}

run_force_leaving(){
  echo $MEMBERS
  if [ ! -z "$MEMBERS" ]
  then
	  echo "Force Leave All Failed Node..."
    echo "-------------------------------"
	  consul members -http-addr=$CONSUL_SERVER | grep failed | awk '{ print $1 }' | xargs -L 1 consul force-leave -http-addr=$CONSUL_SERVER
    echo "-------------------------------"
    echo "Force Leave Done!"
    run_create_log
  fi
}

run_create_log(){
  mkdir -p $PATH_LOG_CONSUL
  echo "List of failed node \
------------------------------------ \
$MEMBERS \
------------------------------------ \
Execute at $SNAPSHOT_LOG" > $LOG_FILE
}

main() {
  run_check_members
  run_force_leaving
}

### START HERE ###
main $@
