require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  let(:user) { create :user, :confirmade }

  describe 'Anónimamente' do
    it 'permite loguearse persistentemente' do
      visit root_path

      click_link 'Entrar'

      within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Contraseña', with: user.password
        check 'Recordarme'
      end

      click_button I18n.t('devise.sessions.new.sign_in')

      _(page).must_have_current_path root_path
      _(page).must_have_content I18n.t('devise.sessions.signed_in')
      _(cookie(:remember_user_token)).must_be :present?
    end

    it 'permite loguearse' do
      login user

      _(page).must_have_current_path root_path
      _(page).must_have_content I18n.t('devise.sessions.signed_in')
      _(cookie(:remember_user_token)).wont_be :present?
    end

    it 'no permite loguearse sin confirmar la cuenta' do
      user = create :user

      login user

      _(page).must_have_current_path new_user_session_path
      _(page).must_have_content I18n.t('devise.failure.unconfirmed')
    end

    describe 'desde el Login' do
      before { visit new_user_session_path }

      it 'permite ir a Recuperar contraseña' do
        click_link I18n.t('devise.shared.links.forgot_your_password')

        _(page).must_have_current_path new_user_password_path
      end

      it 'permite ir a Reenviar confirmación' do
        click_link I18n.t('devise.shared.links.didn_t_receive_confirmation_instructions')

        _(page).must_have_current_path new_user_confirmation_path
      end
    end
  end

  describe 'Logueade' do
    before { login user }

    it 'permite desloguearse' do
      visit root_path

      click_link 'Salir'

      _(page).must_have_current_path root_path
      _(page).must_have_content I18n.t('devise.sessions.signed_out')
    end
  end
end
