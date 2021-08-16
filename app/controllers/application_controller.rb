# Superclase para todos los controladores.
class ApplicationController < ActionController::Base
  # Sistema de permisos a través de clases de reglas ("policies").
  include Pundit
  # Paginación.
  include Pagy::Backend

  # Interceptar todos los errores de autorización.
  rescue_from Pundit::NotAuthorizedError, with: :sin_autorizacion

  private

  # Inicializar un usuario nuevo para autorizar los accesos anónimos con
  # Pundit.
  def pundit_user
    current_user || User.new
  end

  def sin_autorizacion
    flash[:alert] = t('sin_autorizacion')

    respond_to do |format|
      format.html do
        if user_signed_in?
          # Redirigir a la página desde donde viene o al inicio.
          redirect_back fallback_location: root_path
        else
          # Redirigir al login.
          redirect_to new_user_session_path
        end
      end
      # TODO, Implementar manejo de esto en los controllers de Stimulus.
      format.json { render json: { error: t('sin_autorizacion') }, status: :forbidden }
    end
  end
end
