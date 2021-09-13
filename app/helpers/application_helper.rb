# Superclase para todos los helpers.
module ApplicationHelper
  # Paginación.
  include Pagy::Frontend

  # Poner primero el título de página para que se vea en las tabs del
  # navegador.
  def titulo_de_app
    [titulo_de_pagina, Setting.nombre_de_app].reject(&:blank?).join(' | ')
  end

  # Cada página que necesite un título debe definirlo.
  def titulo_de_pagina
    content_for :titulo_de_pagina
  end

  # Para mostrar los mensajes de error de cada atributo al lado del input.
  def mensaje_de_error(registro, atributo)
    return unless registro.errors[atributo].any?

    capture do
      content_tag(:div, class: 'col-lg') do
        content_tag(:small, class: 'text-danger') do
          registro.errors.full_messages_for(atributo).to_sentence
        end
      end
    end
  end
end
