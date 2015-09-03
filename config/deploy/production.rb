role :web,   'kurorekishi.me'
role :app,   'kurorekishi.me'
role :db,    'kurorekishi.me', primary: true

set :deploy_env,  'production'
set :unicorn_env, 'production'
set :rails_env,   'production'
set :app_env,     'production'

set :branch,      'master'
