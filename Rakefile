# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require_relative 'config/application'

Rails.application.load_tasks

# Agregar logger a la terminal para las semillas.
task 'db:seed': :logger

# TODO, Verificar que las factories sean válidas.
# task 'test': 'factory_bot:lint'
