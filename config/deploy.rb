set :application, 'clean_them_all'
set :repo_url, 'https://github.com/cohakim/clean_them_all.git'

set :branch, 'master'
set :deploy_to, "/var/www/app/clean_them_all"

set :format, :pretty
set :log_level, :info

set :rbenv_type, :user
set :rbenv_ruby, '2.4.1'
set :rbenv_path, '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :migration_role, :db
set :assets_roles, %i(web)

set :puma_role, :web
set :puma_init_active_record, true

set :sidekiq_role, %i(app)
set :sidekiq_concurrency, 1
set :sidekiq_monit_conf_dir, '/etc/monit.d'

set :linked_dirs, fetch(:linked_dirs, []).push(
  'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system'
)

set :pty, false
set :bundle_binstubs, nil
