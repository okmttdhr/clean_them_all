require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/yarn'
require 'capistrano/rails'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano/sidekiq'
require 'capistrano/sidekiq/monit'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx
