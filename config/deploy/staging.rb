role :web,   'staging.kurorekishi.me'
role :app,   'staging.kurorekishi.me'
role :db,    'staging.kurorekishi.me', primary: true

set :deploy_env,  'staging'
set :unicorn_env, 'staging'
set :rails_env,   'staging'
set :app_env,     'staging'

current_branch = `git branch`.match(/\* (\S+)\s/m)[1]
set :branch, current_branch || 'staging'
