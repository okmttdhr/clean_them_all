def hosts_for_role(role)
  filter_stage = "'Name=tag:Stage,Values=production'"
  filter_role  = "'Name=tag:Role,Values=*#{role}*'"
  filter_state = "'Name=instance-state-name,Values=running'"
  filters      = [filter_stage, filter_role, filter_state].join(' ')
  query        = "'Reservations[].Instances[].[PrivateIpAddress]'"
  hosts        = %x( aws ec2 describe-instances --filters #{filters} --query #{query} --output text ).split("\n")
end

set :proxy_host, 'manage.kurorekishi.me'
set :ssh_options, {
 user: 'ec2-user',
 keys: %w(~/.ssh/id_rsa.ec2),
 forward_agent: false,
 auth_methods: %w(publickey)
}

%w(web app db).each do |role|
  hosts_for_role(role).each do |host|
    server "#{fetch(:proxy_host)}/#{host}", user: 'ec2-user', roles: [role]
  end
end
