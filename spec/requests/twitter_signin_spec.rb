
# require 'spec_helper'


# describe "Twitter login" do

#   subject { page }

#   before do
#     @user = FactoryGirl.create(:user)
#     sign_in @user
#   end

#   describe "success" do
#     before do
#       request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
#     end


#     it "should create authentication" do
#       lambda do
#         post :create, :provider => "twitter"
#         response.should redirect_to(@user)
#       end.should change(Authentication, :count).by(1)
#     end
#   end
# end