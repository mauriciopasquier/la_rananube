# Configuración general de los tests de sistema.
require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Helpers para inicializar modelos en los tests.
  include FactoryBot::Syntax::Methods

  # No mostrar el log de Puma en stdio.
  Capybara.server = :puma, { Silent: true }

  driven_by :selenium, using: :headless_chrome

  # Cosas a configurar antes de cada test.
  def setup
    # Configurar que los emails se envíen desde el server actual que levantó
    # Capybara.
    ActionMailer::Base.default_url_options = {
      host: page.server.host,
      port: page.server.port
    }
  end

  # Realiza el proceso de login para le usuarie indicade.
  def login(user)
    visit new_user_session_path

    within 'form.login' do
      fill_in User.human_attribute_name(:email), with: user.email
      fill_in User.human_attribute_name(:password), with: user.password
    end

    click_button I18n.t('devise.sessions.new.sign_in')
  end

  # Devuelve una cookie por nombre, o nil si no existe.
  def cookie(nombre)
    cookie_jar.find { |cookie| cookie[:name] == nombre.to_s }
  end

  # Devuelve todas las cookies seteadas en esta sesión.
  def cookie_jar
    page.driver.browser.manage.all_cookies
  end
end
