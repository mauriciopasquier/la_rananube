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
end
