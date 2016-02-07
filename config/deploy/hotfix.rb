region       = ENV['AWS_REGION']
filter_stage = "'Name=tag:Stage,Values=production'"
filter_role  = "'Name=tag:Role,Values=*web*'"
filter_state = "'Name=instance-state-name,Values=running'"
filters      = [filter_stage, filter_role, filter_state].join(' ')
query        = "'Reservations[].Instances[].[PrivateIpAddress]'"
hosts        = %x( aws ec2 describe-instances --region=#{region} --filters #{filters} --query #{query} --output text ).split("\n")

hosts.each do |host|
  role :web, "#{host}"
  role :app, "#{host}"
end
role :db,    "#{hosts.first}", primary: true

set :deploy_env,  'production'
set :unicorn_env, 'production'
set :rails_env,   'production'
set :app_env,     'production'

set :repository,  'https://github.com/cohakim/clean_them_all.git'
current_branch = `git branch`.match(/\* (\S+)\s/m)[1]
set :branch, current_branch || 'master'
set :deploy_via,  :remote_cache

before 'deploy:update' do
  run "rm -rf #{shared_path}/cached-copy"
end

require 'capistrano/deploy/tagger'
set :latest_deploy_tag, 'inproduction'
set :latest_deploy_timestamp_tag_prefix, 'hotfix'
set :latest_deploy_timestamp_tag_format, "%Y%m%d-%H%M%S"
set :update_deploy_tags, true
set :update_deploy_timestamp_tags, true
