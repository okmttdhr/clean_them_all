region = ENV['AWS_REGION']
filter_hostname   = "'Name=tag:Name,Values=web*'"
filter_production = "'Name=tag:Environment,Values=production'"
filter_running    = "'Name=instance-state-name,Values=running'"
filters           = [filter_production, filter_running, filter_hostname].join(' ')
query             = "'sort_by(Reservations[].Instances[].{Tags:Tags[?Key==`Name`].Value|[0]},&Tags)'"
hosts = %x( aws ec2 describe-instances --region=#{region} --filters #{filters} --query #{query} --output text ).split("\n")

hosts.each do |hostname|
  role :web, "#{hostname}.kurorekishi.me"
end
role :app,   "#{hosts.first}.kurorekishi.me"
role :db,    "#{hosts.first}.kurorekishi.me", primary: true

set :deploy_env,  'production'
set :unicorn_env, 'production'
set :rails_env,   'production'
set :app_env,     'production'

set :repository,  'https://github.com/cohakim/clean_them_all.git'
set :branch,      'master'
set :deploy_via,  :remote_cache

require 'capistrano/deploy/tagger'
set :latest_deploy_tag, 'inproduction'
set :latest_deploy_timestamp_tag_prefix, 'release'
set :latest_deploy_timestamp_tag_format, "%Y%m%d-%H%M%S"
set :update_deploy_tags, true
set :update_deploy_timestamp_tags, true
