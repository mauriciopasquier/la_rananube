# Configuración default del sitio.
class Setting < RailsSettings::Base
  cache_prefix { 'v1' }

  field :nombre_de_app, type: :string, default: 'La Rananube'
end
