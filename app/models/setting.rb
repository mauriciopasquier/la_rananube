# Configuración default del sitio.
class Setting < RailsSettings::Base
  cache_prefix { 'v2' }

  field :nombre_de_app, type: :string, default: 'La Rananube'
  field :url, type: :string,
    default: Rails.application.credentials.url
end
