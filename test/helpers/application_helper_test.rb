require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  describe ApplicationHelper do
    describe '#titulo_de_aplicacion' do
      it 'devuelve el nombre de la app por default' do
        _(titulo_de_aplicacion).must_equal 'La Rananube'
      end

      it 'incorpora el título de página, si existe' do
        stub :titulo_de_pagina, 'Cosa' do
          _(titulo_de_aplicacion).must_equal 'Cosa | La Rananube'
        end

        stub :titulo_de_pagina, '' do
          _(titulo_de_aplicacion).must_equal 'La Rananube'
        end

        stub :titulo_de_pagina, nil do
          _(titulo_de_aplicacion).must_equal 'La Rananube'
        end
      end
    end
  end
end
