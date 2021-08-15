require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  let(:usuarie) { create :user, :confirmade, :administracion }
  let(:otre_usuarie) { create :user }

  describe 'con permisos de administracion' do
    before { login usuarie }

    it 'lista les usuaries' do
      _(otre_usuarie).must_be :persisted?

      visit users_path

      _(page).must_have_content usuarie.email
      _(page).must_have_content usuarie.nombre
      _(page).must_have_content otre_usuarie.email
      _(page).must_have_content otre_usuarie.nombre
    end

    it 'crea usuaries' do
      visit users_path

      click_on 'New User'

      user_params = attributes_for :user
      fill_in User.human_attribute_name(:email), with: user_params[:email]
      fill_in User.human_attribute_name(:nombre), with: user_params[:nombre]
      fill_in User.human_attribute_name(:password), with: user_params[:password]
      fill_in User.human_attribute_name(:password_confirmation),
        with: user_params[:password_confirmation]

      click_on I18n.t('helpers.submit.create', model: User.model_name.human)

      _(page).must_have_current_path users_path
      _(page).must_have_content I18n.t('users.create.notice')
      _(page).must_have_content user_params[:email]
    end

    it 'actualiza usuaries' do
      _(otre_usuarie).must_be :persisted?

      visit users_path

      within "#user-#{otre_usuarie.id}" do
        click_on 'Edit'
      end

      user_params = attributes_for :user
      fill_in User.human_attribute_name(:email), with: user_params[:email]
      fill_in User.human_attribute_name(:nombre), with: user_params[:nombre]

      click_on I18n.t('helpers.submit.update', model: User.model_name.human)
      _(page).must_have_current_path user_path(otre_usuarie)
      _(page).must_have_content I18n.t('users.update.notice')
      _(page).must_have_content user_params[:email]
      _(page).must_have_content user_params[:nombre]
    end

    it 'destruye usuaries' do
      _(otre_usuarie).must_be :persisted?

      visit users_path

      within "#user-#{otre_usuarie.id}" do
        page.accept_confirm do
          click_on 'Destroy'
        end
      end

      _(page).must_have_current_path users_path
      _(page).must_have_content I18n.t('users.destroy.notice')
      _(page).wont_have_content otre_usuarie.email
    end
  end
end
