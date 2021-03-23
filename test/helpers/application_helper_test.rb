require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  describe ApplicationHelper do
    describe '#titulo_de_app' do
      it 'devuelve el nombre de la app por default' do
        _(titulo_de_app).must_equal Setting.nombre_de_app
      end

      it 'incorpora el título de página, si existe' do
        stub :titulo_de_pagina, 'Cosa' do
          _(titulo_de_app).must_equal "Cosa | #{Setting.nombre_de_app}"
        end

        stub :titulo_de_pagina, '' do
          _(titulo_de_app).must_equal Setting.nombre_de_app
        end

        stub :titulo_de_pagina, nil do
          _(titulo_de_app).must_equal Setting.nombre_de_app
        end
      end
    end
  end
end
