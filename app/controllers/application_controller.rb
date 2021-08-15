# Superclase para todos los controladores.
class ApplicationController < ActionController::Base
  # Sistema de permisos a través de clases de reglas ("policies").
  include Pundit
end
