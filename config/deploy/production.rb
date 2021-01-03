# Deploy en entorno de producción.
set :deploy_user, ENV['LA_RANANUBE_DEPLOY_USER']
set :deploy_to, ENV['LA_RANANUBE_DEPLOY_PATH']

server ENV['LA_RANANUBE_DEPLOY_SERVER'],
  user: fetch(:deploy_user),
  roles: %w[app web db]
