require 'spec_helper'

describe AuthenticationsController do

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "success" do
    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    end


    it "should create authentication" do
      lambda do
        post :create
        response.should redirect_to(root_path)
      end.should change(Authentication, :count).by(1)
    end
  end
end
