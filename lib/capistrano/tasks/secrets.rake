namespace :deploy do
  task :secrets do
    on roles([:web, :app]) do
      execute "/bin/mkdir -p #{shared_path}/config/"
      upload! 'config/secrets.yml.key', "#{shared_path}/config/secrets.yml.key"
    end
  end
end
