# Mailer genérico de la aplicación.
class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.mailer[:from]
  layout 'mailer'
end
