require 'application_system_test_case'

class NavegacionTest < ApplicationSystemTestCase
  let(:usuarie) { create :user, :confirmade }

  describe 'anónimamente' do
    before { visit root_path }

    it 'no hay menú de Administración' do
      _(page).wont_have_content 'Administración'
    end
  end

  describe 'logueade' do
    before { login usuarie }

    it 'hay menú de Administración' do
      _(page).must_have_content 'Administración'
    end

    it 'hay menú de Usuaries' do
      click_on I18n.t('layouts.menu.administracion')
      click_on I18n.t('layouts.menu.usuaries')

      _(page).must_have_current_path users_path
    end
  end
end
