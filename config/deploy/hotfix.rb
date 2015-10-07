role :web,   'web01.kurorekishi.me'
role :app,   'web01.kurorekishi.me'
role :db,    'web01.kurorekishi.me', primary: true

set :deploy_env,  'production'
set :unicorn_env, 'production'
set :rails_env,   'production'
set :app_env,     'production'

set :repository,  'https://github.com/cohakim/clean_them_all.git'
set :deploy_via,  :remote_cache
current_branch = `git branch`.match(/\* (\S+)\s/m)[1]
set :branch, current_branch || 'master'

require 'capistrano/deploy/tagger'
set :latest_deploy_tag, 'inproduction'
set :latest_deploy_timestamp_tag_prefix, 'hotfix'
set :latest_deploy_timestamp_tag_format, "%Y%m%d-%H%M%S"
set :update_deploy_tags, true
set :update_deploy_timestamp_tags, true
