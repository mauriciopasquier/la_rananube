# Configuración de tests general.

ENV['RAILS_ENV'] ||= 'test'
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
