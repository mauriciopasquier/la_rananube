# Tareas relacionadas con FactoryBot.
namespace :factory_bot do
  # "Lintear" todas las factories. Esto tiene que correr bien antes de correr
  # los tests si hemos cambiado alguna factory.
  desc 'Verify that all FactoryBot factories are valid'
  task lint: :environment do
    if Rails.env.test?
      # Envolverlo en una transacción asegura que la base de datos quede
      # limpia.
      ActiveRecord::Base.transaction do
        # Si alguna falla, acá se larga una exception.
        FactoryBot.lint FactoryBot.factories

        # Si ninguna falla, forzamos el rollback.
        puts 'Todas las factories pasaron.'
        raise ActiveRecord::Rollback
      end
    else
      # Forzar entorno de test.
      system 'RAILS_ENV=test rails factory_bot:lint'
    end
  end
end
