#def full_title(page_title)
#  base_title = "Ruby on Rails Tutorial Sample App"
#  if page_title.empty?
#    base_title
#  else
#    "#{base_title} | #{page_title}"
#  end
#end

include ApplicationHelper
include SessionsHelper




def valid_signin(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  #signin when not using capybara as well
  cookies[:remember_token] = user.remember_token
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
    page.should have_link('Sign out', href: signout_path)
  end
end


RSpec::Matchers.define :be_logged_out do |i|
  match do |page|
    page.should have_link('Sign in', href: signin_path)
  end
end