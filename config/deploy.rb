# Capistrano Einstellungen
require "bundler/capistrano"
require "sidekiq/capistrano"
default_run_options[:pty] = true
set :default_shell, "bash -l"

# App Einstellungen
set :application, "Koedok"            # Der Name deiner App.
set :domain, 'koedok.com'
set :server_ip, "37.72.147.2"            # Deine Railscloud IPv4 Adresse.
set :user, "railsvm"                    # Deployment User
set :git_repo, "https://github.com/hendra-sasmito/footprint32.git"    # z.B.: git@github.com:user/repo.git
#set :git_repo, "ssh://railsvm@37.72.147.2/~/projectdir.git"

# Deployment Einstellungen
set :appdir, "/usr/local/nginx/html/"
set :use_sudo, false
set :keep_releases, 2
set :deploy_to, appdir

# Git / Version Control
set :scm, :git
set :repository, git_repo     
set :branch, "master"                  # Branch auswaehlen
set :git_enable_submodules, 1          # Git Submodules ebenfalls fetchen.


# Roles
role :web, server_ip
role :app, server_ip
role :db,  server_ip, :primary => true

# Sidekiq
set(:sidekiq_cmd) { "bundle exec sidekiq" }

# Passenger - automatischer Neustart nach Code Update.
namespace :passenger do
  desc "Restart Application"  
  task :restart do  
    run "touch #{current_path}/tmp/restart.txt"  
  end
end
after :deploy, "deploy:cleanup"
after :deploy, "passenger:restart"

namespace :deploy do
  task :setup_solr_data_dir do
    run "mkdir -p #{shared_path}/solr/data"
  end
end
 
namespace :solr do
  desc "start solr"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec sunspot:solr:start --port=8983 --data-directory=#{shared_path}/solr/data --pid-dir=#{shared_path}/pids"
  end
  desc "stop solr"
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec sunspot:solr:stop --port=8983 --data-directory=#{shared_path}/solr/data --pid-dir=#{shared_path}/pids"
  end
  desc "reindex the whole database"
  task :reindex, :roles => :app do
    stop
    run "rm -rf #{shared_path}/solr/data"
    start
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:reindex"
  end
end
 
after 'deploy', "deploy:setup_solr_data_dir"