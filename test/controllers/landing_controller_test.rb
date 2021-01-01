require "test_helper"

class LandingControllerTest < ActionDispatch::IntegrationTest
  describe '#index' do
    it 'hay un landing' do
      get root_url 

      must_respond_with :success
    end
  end
end
