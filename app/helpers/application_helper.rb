# Superclase para todos los helpers.
module ApplicationHelper
  # Poner primero el título de página para que se vea en las tabs del
  # navegador.
  def titulo_de_aplicacion
    [titulo_de_pagina, 'La Rananube'].reject(&:blank?).join(' | ')
  end

  # Cada página que necesite un título debe definirlo.
  def titulo_de_pagina
    content_for :titulo_de_pagina
  end
end
