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

    describe '#notificaciones' do
      it 'prepara notificaciones para los tipos permitidos' do
        mensajes = {
          'success' => 'Éxito',
          'error' => 'Fracaso',
          'alert' => 'Alarma',
          'notice' => 'Mensaje',
          'inexistente' => 'Inexistente'
        }

        stub :flash, mensajes do
          _(notificaciones).must_match 'Éxito'
          _(notificaciones).must_match 'Fracaso'
          _(notificaciones).must_match 'Alarma'
          _(notificaciones).must_match 'Mensaje'
          _(notificaciones).wont_match 'Inexistente'
        end
      end
    end
  end
end
