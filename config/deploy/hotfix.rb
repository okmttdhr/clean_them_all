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
