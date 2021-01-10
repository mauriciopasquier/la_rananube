# Cada usuarie del sistema.
class User < ApplicationRecord
  # No permitir registro manual.
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
    :confirmable, :trackable
end
