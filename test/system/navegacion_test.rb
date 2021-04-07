require 'application_system_test_case'

class NavegacionTest < ApplicationSystemTestCase
  let(:user) { create :user, :confirmade }

  describe 'Anónimamente' do
    before { visit root_path }

    it 'no hay menú de Administración' do
      _(page).wont_have_content 'Administración'
    end
  end

  describe 'Logueade' do
    before { login user }

    it 'hay menú de Administración' do
      _(page).must_have_content 'Administración'
    end

    it 'hay menú de Usuarixs' do
      click_link 'Administración'
      click_link 'Usuarixs'

      _(page).must_have_current_path users_path
    end
  end
end