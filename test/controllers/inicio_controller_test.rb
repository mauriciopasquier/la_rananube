require 'test_helper'

describe InicioController do
  describe '#index' do
    it 'hay un inicio' do
      get root_url

      must_respond_with :success
    end
  end
end
