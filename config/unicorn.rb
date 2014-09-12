MY_APP_NAME="REPLACE_WITH_APP_NAME"
USER = "REPLACE_WITH_USERNAME"
root = "/home/#{USER}/apps/#{MY_APP_NAME}/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.#{MY_APP_NAME}.sock"
worker_processes 2
timeout 30
