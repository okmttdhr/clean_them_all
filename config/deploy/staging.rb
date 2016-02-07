region       = ENV['AWS_REGION']
filter_stage = "'Name=tag:Stage,Values=staging'"
filter_role  = "'Name=tag:Role,Values=*web*'"
filter_state = "'Name=instance-state-name,Values=running'"
filters      = [filter_stage, filter_role, filter_state].join(' ')
query        = "'Reservations[].Instances[].[PrivateIpAddress]'"
hosts        = %x( aws ec2 describe-instances --region=#{region} --filters #{filters} --query #{query} --output text ).split("\n")

hosts.each do |host|
  role :web, "manage.kurorekishi.me/#{host}"
  role :app, "manage.kurorekishi.me/#{host}"
end
role :db,    "manage.kurorekishi.me/#{hosts.first}", primary: true

set :deploy_env,  'staging'
set :unicorn_env, 'staging'
set :rails_env,   'staging'
set :app_env,     'staging'

current_branch = `git branch`.match(/\* (\S+)\s/m)[1]
set :branch, current_branch || 'staging'

require 'capistrano/deploy/tagger'
set :latest_deploy_tag, 'instaging'
set :update_deploy_tags, true
set :update_deploy_timestamp_tags, false
