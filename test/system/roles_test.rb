require 'application_system_test_case'

class RolesTest < ApplicationSystemTestCase
  let(:usuarie) { create :user, :confirmade, :administracion }
  let(:otre_usuarie) { create :user }

  describe 'logueade' do
    before { login usuarie }

    it 'no se puede sacar la administración' do
      visit users_path

      within "#user-#{usuarie.id}" do
        _(page).must_have_checked_field name: 'roles[administracion]', disabled: true
      end
    end

    it 'modifica roles' do
      _(otre_usuarie).must_be :persisted?

      visit users_path

      within "#user-#{otre_usuarie.id}" do
        check name: 'roles[administracion]'
        check name: 'roles[clientes]'
        click_on 'Show'
      end

      _(page).must_have_current_path user_path(otre_usuarie)

      within '.usuarie' do
        _(page).must_have_content User.roles.administracion.text
        _(page).must_have_content User.roles.clientes.text
      end
    end
  end
end
