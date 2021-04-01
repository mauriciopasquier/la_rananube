# Superclase para todos los helpers.
module ApplicationHelper
  # Poner primero el título de página para que se vea en las tabs del
  # navegador.
  def titulo_de_app
    [titulo_de_pagina, Setting.nombre_de_app].reject(&:blank?).join(' | ')
  end

  # Cada página que necesite un título debe definirlo.
  def titulo_de_pagina
    content_for :titulo_de_pagina
  end

  # Genera alertas de notifiación para cada mensaje del sistema.
  def notificaciones
    capture do
      flash.to_hash.slice('success', 'error', 'alert', 'notice').each do |tipo, mensaje|
        concat(
          # Determinar la clase según el tipo.
          content_tag(:div, class: clases_notificacion(tipo)) do
            concat(
              # Botón de cerrar notificación.
              content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
                content_tag :span, '&times;'.html_safe
              end
            )

            # TODO, Verificar que no necesite `.html_safe`.
            concat mensaje
          end
        )
      end
    end
  end

  private

  # Determina las clases de cada notificación, usado en `notificaciones`, según
  # su tipo.
  def clases_notificacion(tipo)
    base = %w[alert alert-dismissable fade show]

    base.push({
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-danger',
      notice: 'alert-success'
    }.stringify_keys[tipo.to_s] || tipo.to_s)

    base.join ' '
  end
end
