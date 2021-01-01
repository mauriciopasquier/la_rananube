# Configuración de tests general.

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/pride'
# Enable spec DSL.
require 'minitest/rails'
require 'capybara/minitest/spec'

class ActiveSupport::TestCase
  # Correr los tests con workers en paralelo. Definir temporalmente con la
  # variable de entorno PARALLEL_WORKERS.
  parallelize workers: :number_of_processors
end
