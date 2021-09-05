# Cada usuarie del sistema.
class User < ApplicationRecord
  extend Enumerize

  # No permitir registro manual.
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
    :confirmable, :trackable

  # Roles para cada subsistema del sitio.
  enumerize :roles, multiple: true,
    in: [:administracion, :clientes]

  validates :nombre, presence: true
end
