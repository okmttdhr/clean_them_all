set :application, 'clean_them_all'
set :user,        'ec2-user'
ssh_options[:keys] = '~/.ssh/ec2/id_rsa'
set :use_sudo,    false

set :scm,         :git
set :branch,      'vpc'
set :repository,  '~/Dropbox/Projects/Service/clean_them_all'
set :deploy_via,  :copy
set :deploy_to,   '/var/www/app/clean_them_all'

# for capistrano-ext
set :stages, ['production']
set :default_stage, 'production'
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

# for dotenv
require 'dotenv/capistrano'

# for unicorn
require 'capistrano-unicorn'
set :unicorn_env, 'production'
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
