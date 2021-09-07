# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Usar Git.
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/webpacker/precompile'
ENV['PRECOMPILE_MODE'] = 'local'
require 'capistrano/precompile_chooser'
require 'capistrano/rails/migrations'

# Servidor de aplicaciones. Debe estar después de rbenv.
require 'capistrano/puma'
install_plugin Capistrano::Puma

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
