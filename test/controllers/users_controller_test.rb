require 'test_helper'

describe UsersController do
  subject { create :user, :confirmade }

  describe 'con permisos' do
    before { sign_in subject }

    it 'accede al index' do
      get users_path

      must_respond_with :success
    end
  end
end
