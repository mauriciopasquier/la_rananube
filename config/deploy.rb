# Configuración de deploy.
lock '~> 3.14.1'

set :application, 'la_rananube'
set :repo_url, 'git@github.com:mauriciopasquier/la_rananube.git'
set :branch, ENV['DEPLOY_BRANCH'] || :main

# Valores default de capistrano.
set :format, :pretty
set :log_level, :debug
set :pty, false
set :keep_releases, 5
set :format_options, command_output: true, log_file: 'log/capistrano.log',
  color: :auto, truncate: :auto

# rbenv.
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

# rails.
# Seleccionar la llave de las credenciales según el entorno.
set :key_path, "config/credentials/#{fetch(:stage)}.key"

append :linked_dirs,
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'storage',
  'public/packs'

append :linked_files,
  fetch(:key_path)

# Puma.
set :puma_preload_app, true
set :puma_init_active_record, true

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Tareas extras.
after 'deploy:updated', 'webpacker:precompile'
