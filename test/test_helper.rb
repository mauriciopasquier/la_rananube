# Configuración de tests general.

ENV['RAILS_ENV'] ||= 'test'

# Iniciar reporte de coverage. Debe iniciarse antes de cargar el resto de la
# aplicación.
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
  Rails.application.eager_load!

  # SimpleCov no funciona con muchos workers a la vez.
  ENV['PARALLEL_WORKERS'] = '1'
end

require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/pride'
# Enable spec DSL.
require 'minitest/rails'
require 'capybara/minitest/spec'

class ActiveSupport::TestCase
  # Helpers para inicializar modelos.
  include FactoryBot::Syntax::Methods

  # Correr los tests con workers en paralelo. Definir temporalmente con la
  # variable de entorno PARALLEL_WORKERS.
  parallelize workers: :number_of_processors
end

class ActionDispatch::IntegrationTest
  # Helpers para loguear y desloguear.
  include Devise::Test::IntegrationHelpers
  # Expectations de mailers.
  include Minitest::Rails::Expectations::ActionMailer
end
