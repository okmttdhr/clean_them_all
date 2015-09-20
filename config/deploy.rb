set :application, 'clean_them_all'
set :user,        'ec2-user'
set :use_sudo,    false

set :scm,         :git
set :repository,  '.'
set :deploy_via,  :copy
set :deploy_to,   '/var/www/app/clean_them_all'

# for capistrano-ext
set :stages, ['production', 'hotfix', 'staging']
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

# for asset pipeline
set :normalize_asset_timestamps, false

# for bundler
require 'bundler/capistrano'
set :bundle_gemfile,  'Gemfile'
set :bundle_dir,      File.join(fetch(:shared_path), 'bundle')
set :bundle_flags,    '--quiet'
set :bundle_without,  [:development, :test]
set :bundle_cmd,      'bundle'
set :bundle_roles,    [:web]

# for unicorn
require 'capistrano-unicorn'
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
set :unicorn_bin, 'unicorn'

# for unicorn sockets
after 'deploy:create_symlink' do
  run "mkdir -p #{shared_path}/sockets"
  run "rm -f #{current_path}/tmp/sockets"
  run "ln -s #{shared_path}/sockets #{current_path}/tmp/sockets"
end

# for maintenance
require 'capistrano/maintenance'
namespace :deploy do
  namespace :web do
    task :disable, roles: :web do
      on_rollback { rm "#{shared_path}/system/maintenance.html" }
      require 'erb'
      maintenance = ERB.new(File.read('./app/views/layouts/maintenance.erb')).result(binding)
      put maintenance, "#{shared_path}/system/maintenance.html", mode: 0644
    end
  end
end

# create database
desc 'execute before deploy:migrate'
before 'deploy:migrate' do
  run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake db:create"
end

# for remote_syslog
namespace :remote_syslog do
  task :start, roles: :app do
    configfile = File.join(current_path, 'config', 'log_files.yml')
    pidfile = File.join(current_path, 'tmp', 'pids', 'remote_syslog.pid')
    run "cd #{current_path}; bundle exec remote_syslog -c #{configfile} --pid-file=#{pidfile} --hostname=#{stage}-`hostname -s`"
  end

  task :stop, roles: :app do
    pidfile = File.join(current_path, 'tmp', 'pids', 'remote_syslog.pid')
    run "cd #{current_path}; kill -TERM $(cat #{pidfile})"
  end
end
