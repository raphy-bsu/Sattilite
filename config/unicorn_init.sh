#!/bin/sh
### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Manage unicorn server
# Description:       Start, stop, restart unicorn server for a specific application.
### END INIT INFO
set -e

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_NAME="REPLACE_WITH_APP_NAME"
AS_USER="REPLACE_WITH_USERNAME"
APP_ROOT="/home/$AS_USER/apps/$APP_NAME/current"
PID="$APP_ROOT/tmp/pids/unicorn.pid"
CMD="cd $APP_ROOT; bundle exec unicorn -D -c $APP_ROOT/config/unicorn.rb -E production"
set -u

MASTER_PID=`ps aux | grep 'unicorn master' | awk '/REPLACE_WITH_APP_NAME/ {print $2}'`

# Send signal to process
sig () {
  if [ -n "$MASTER_PID" ]; then
    echo "Sending signal $1 to $MASTER_PID"
    kill -s $1 $MASTER_PID
  else
    return 1
  fi
}

# Ececute command as user
run () {
  if [ "$(id -un)" = "$AS_USER" ]; then
    eval $1
  else
    su -c "$1" - $AS_USER
  fi
}

case "$1" in
start)
  sig 0 && echo >&2 "Already running" && exit 0
  run "$CMD"
  ;;
stop)
  sig QUIT && exit 0
  echo >&2 "Not running"
  ;;
force-stop)
  sig TERM && exit 0
  echo >&2 "Not running"
  ;;
restart|reload)
  echo 'reloading'
  if !(sig HUP); then
    echo >&2 "Couldn't reload, starting '$CMD' instead"
    run "$CMD"
  fi
  echo 'reloader [OK]'
  ;;
reopen-logs)
  sig USR1
  ;;
*)
  echo >&2 "Usage: $0 <start|stop|restart|force-stop|reopen-logs>"
  exit 1
  ;;
esac
