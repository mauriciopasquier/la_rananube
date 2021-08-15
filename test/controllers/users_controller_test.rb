require 'test_helper'

describe UsersController do
  let(:usuarie) { create :user, :confirmade, :administracion }
  let(:otre_usuarie) { create :user }

  describe 'con permisos de administración' do
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

    it 'modifica roles' do
      _(otre_usuarie.roles).wont_be :administracion?

      patch roles_user_path(otre_usuarie),
        params: { roles: { administracion: true } }, as: :json

      must_respond_with :success
      _(otre_usuarie.reload.roles).must_be :administracion?

      patch roles_user_path(otre_usuarie),
        params: { roles: { administracion: false } }, as: :json

      _(otre_usuarie.reload.roles).wont_be :administracion?
    end

    it 'no puede sacarse su rol de administración' do
      _(usuarie.roles).must_be :administracion?

      patch roles_user_path(usuarie),
        params: { roles: { administracion: false } }, as: :json

      must_respond_with :unprocessable_entity
      _(usuarie.reload.roles).must_be :administracion?
    end
  end

  describe 'sin permisos de administración' do
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

    it 'no modifica roles' do
      patch roles_user_path(otre_usuarie),
        params: { roles: { clientes: true } }, as: :json

      must_respond_with :forbidden
      _(otre_usuarie.reload.roles).wont_be :clientes?
    end
  end
end
