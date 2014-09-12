# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'sattilite'


set :scm, :git
set :repo_url, 'https://github.com/OrelSokolov/Sattilite'

set :rbenv_type, :user
set :rbenv_ruby, '2.1.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :pty, true

set :keep_releases, 5


# files we want symlinking to specific entries in shared.
# set :linked_files, %w{config/database.yml}
# set :linked_files, %w{config/application.yml}

# set(:config_files, %w(
#   nginx.conf
#   database.yml.example
#   unicorn.rb
#   unicorn_init.sh
# ))

# set(:executable_config_files, %w(
#   unicorn_init.sh
# ))


# # files which need to be symlinked to other parts of the
# # filesystem. For example nginx virtualhosts, log rotation
# # init scripts etc.
set(:symlinks, [
  {
    source: "config/nginx.conf",
    link: "/etc/nginx/sites-enabled/#{fetch(:application)}"
  },
  {
    source: "config/unicorn_init.sh",
    link: "/etc/init.d/unicorn_#{fetch(:application)}"
  }
])

set(:services, [
    "config/unicorn_init.sh",
    "config/nginx.conf",
    "config/unicorn.rb"
  ])


# namespace :deploy do
#   task :setup_config do
#     sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
#     sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{fetch(:application)}"
#     run "mkdir -p #{shared_path}/config"
#     put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
#     puts "Now edit the config files in #{shared_path}."
#   end

#   task :symlink_config do
#     run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#   end

#   desc "Make sure local git is in sync with remote."
#   task :check_revision do
#     unless `git rev-parse HEAD` == `git rev-parse origin/master`
#       puts "WARNING: HEAD is not the same as origin/master"
#       puts "Run `git push` to sync changes."
#       exit
#     end
#   end

#   before "deploy", "deploy:check_revision"
#   # make sure we're deploying what we think we're deploying
#   before :deploy, "deploy:check_revision"
#   # only allow a deploy with passing tests to deployed
#   before :deploy, "deploy:run_tests"
#   # compile assets locally then rsync
#   # after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
#   after :finishing, 'deploy:cleanup'

#   # remove the default nginx configuration as it will tend
#   # to conflict with our configs.
#   # before 'deploy:setup_config', 'nginx:remove_default_vhost'

#   # reload nginx to it will pick up any modified vhosts from
#   # setup_config
#   # after 'deploy:setup_config', 'nginx:reload'

#   # As of Capistrano 3.1, the `deploy:restart` task is not called
#   # automatically.
#   # after 'deploy:publishing', 'deploy:restarapi'



# end

namespace :deploy do

  # %w[start stop restart].each do |command|
  #     desc "#{command} unicorn server"
  #     task command, roles: :app, except: {no_release: true} do
  #       # sudo "killall ruby"
  #       # sudo "chmod +x /etc/init.d/unicorn_#{application}"
  #       # sudo "/etc/init.d/unicorn_#{application} #{command}"
  #       sudo "service unicorn_#{fetch(:application)} #{command}"
  #       sudo "service nginx #{command}"
  #     end
  #   end

  task :symlink_config do
    fetch(:symlinks).each do |symlink|
      on roles(:all) do |host|
        execute :sudo, "ln -nfs #{File.join(current_path, symlink[:source])} #{symlink[:link]}"
        # execute :sudo, "chmod +x #{symlink[:link]}"
        execute "sed -i 's/REPLACE_WITH_APP_NAME/#{fetch(:application)}/g' #{File.join(current_path, symlink[:source])}"
        execute "sed -i 's/REPLACE_WITH_USERNAME/#{fetch(:deploy_user)}/g' #{File.join(current_path, symlink[:source])}"
      end
    end
    on roles(:all) do |host|
      execute "mkdir -p #{File.join(current_path, '/tmp/pids/')}"
    end
  end
  after "deploy:publishing", "deploy:symlink_config"

  task :generate_services_files do
    fetch(:services).each do |service_file|
      on roles(:all) do |host|
        execute "sed -i 's/REPLACE_WITH_APP_NAME/#{fetch(:application)}/g' #{File.join(current_path, service_file)}"
        execute "sed -i 's/REPLACE_WITH_USERNAME/#{fetch(:deploy_user)}/g' #{File.join(current_path, service_file)}"
      end
    end
  end
  after "deploy:publishing", "deploy:generate_services_files"

  task :register_services do
    on roles(:all) do |host|
      execute :sudo, "update-rc.d unicorn_#{fetch(:application)} defaults"
      # execute :sudo, "systemctl daemon-reload"
    end
  end
  after "deploy:generate_services_files", "deploy:register_services"

  task :restart_services do
    on roles(:all) do |host|
      execute :sudo, "service unicorn_#{fetch(:application)} stop"
      execute :sudo, "service unicorn_#{fetch(:application)} start"
      execute :sudo, "service nginx restart"
    end
  end
  after "deploy:register_services", "deploy:restart_services"

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
