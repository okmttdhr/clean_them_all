role :web,   'web01.kurorekishi.me'
role :app,   'web01.kurorekishi.me'
role :db,    'web01.kurorekishi.me', primary: true

set :deploy_env,  'production'
set :unicorn_env, 'production'
set :rails_env,   'production'
set :app_env,     'production'

set :repository,  'https://github.com/cohakim/clean_them_all.git'
set :branch,      'master'
set :deploy_via,  :remote_cache

require 'capistrano/deploy/tagger'
set :latest_deploy_tag, 'release'
set :update_deploy_tags, true
set :update_deploy_timestamp_tags, true
