#def full_title(page_title)
#  base_title = "Ruby on Rails Tutorial Sample App"
#  if page_title.empty?
#    base_title
#  else
#    "#{base_title} | #{page_title}"
#  end
#end

include ApplicationHelper
include AuthenticationsHelper
include SessionsHelper



def valid_signin(user)
  # visit signin_path
  # fill_in "Email",    with: user.email
  # fill_in "Password", with: user.password
  # click_button "Sign in"
  # #signin when not using capybara as well
  # cookies[:remember_token] = user.remember_token
  # session[:user_id] = user.id

    #request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    visit signin_path

    myAuth = Authentication.find_by_uid("12345")
    myAuth.user_id = user.id
    myAuth.save!
    
    #for admin testing
    if user.admin?
       myAuth = Authentication.find_by_uid("12345")
       this_user = User.find_by_id(myAuth.user_id)
       this_user.admin = true
       this_user.save!
    end
end


RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end


RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end


RSpec::Matchers.define :be_logged_in do |i|
  match do |page|
    page.should have_link('Sign Out', href: signout_path)
  end
end


RSpec::Matchers.define :be_logged_out do |i|
  match do |page|
    page.should have_link('Sign In', href: signin_path)
  end
end