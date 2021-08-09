require 'test_helper'

describe UsersController do
  let(:usuarie) { create :user, :confirmade }
  let(:otre_usuarie) { create :user }

  describe 'con permisos' do
    before { sign_in usuarie }

    it 'accede al index' do
      get users_path

      must_respond_with :success
    end

    it 'accede a new' do
      get new_user_path

      must_respond_with :success
    end

    it 'accede a show' do
      get user_path(otre_usuarie)

      must_respond_with :success
    end

    it 'accede a edit' do
      get edit_user_path(otre_usuarie)

      must_respond_with :success
    end

    it 'crea usuaries' do
      _(lambda do
        post users_path, params: { user: attributes_for(:user) }
      end).must_differ 'User.count'

      must_redirect_to users_path
    end

    it 'actualiza usuaries' do
      _(otre_usuarie).must_be :persisted?
      user_params = attributes_for :user

      put user_path(otre_usuarie),
        params: { user: user_params }

      otre_usuarie.reload
      # Usamos unconfirmed_email, porque devise guarda ahí el nuevo mail hasta confirmarlo.
      _(otre_usuarie.unconfirmed_email).must_equal user_params[:email]
      _(otre_usuarie.nombre).must_equal user_params[:nombre]

      must_redirect_to user_path(otre_usuarie)
    end

    it 'destruye usuaries' do
      _(otre_usuarie).must_be :persisted?

      _(lambda do
        delete user_path(otre_usuarie)
      end).must_differ 'User.count', -1

      must_redirect_to users_path
    end
  end

  describe 'sin permisos' do
    it 'no accede a vistas restringidas' do
      _(otre_usuarie).must_be :persisted?

      [
        users_path,
        new_user_path,
        user_path(otre_usuarie),
        edit_user_path(otre_usuarie)
      ].each do |ruta_restringida|
        get ruta_restringida

        must_redirect_to root_path
      end
    end

    it 'no actualiza usuaries' do
      put user_path(otre_usuarie), params: { user: attributes_for(:user) }

      must_redirect_to root_path
    end

    it 'no crea usuaries' do
      post users_path, params: { user: attributes_for(:user) }

      must_redirect_to root_path
    end

    it 'no destruye usuaries' do
      delete user_path(otre_usuarie)

      must_redirect_to root_path
    end
  end
end
