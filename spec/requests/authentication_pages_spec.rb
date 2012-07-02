require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      #it { should have_selector('div.alert.alert-error', text: 'Invalid') }
		  it { should have_error_message('Invalid') }


  		describe "after visiting another page" do
  		  before { click_link "Home" }
  		  it { should_not have_selector('div.alert.alert-error') }
  		end

    end


    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_link('Sign out', href: signout_path) }
      it { should have_content(user.name) }
      it { should be_logged_in }
      it { should_not be_logged_out }
      it { should have_content("All the Issues!")}

      describe "redirect from unnecessary actions" do
        describe "new or create action" do
          before { visit signup_path }
          it { should have_selector('h1', text: "Agree the People") }
          #got redirected back to the root
        end
      end


      ################################################
      describe "admin shouldnt be able to delete himself" do
        before do
          visit users_path
        end
        it { should_not have_link('delete', href: user_path(user)) }

      end


    end
  end


  describe "Authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "no personal links" do
        it { should_not have_link('Profile') }
        it { should_not have_link('Users') }
        it { should_not have_link('Settings') }
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          # i guess this means we should be redirected to the sign in page
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end


      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          # because capybara, just like browser, can't issue a put through UI
          # this issues a direct put request
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Sign in') }
        end

      end

    end


    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { valid_signin user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      before { valid_signin non_admin }

      describe "submitting a DELETE request to Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end

      it "should not allow access to admin" do
        expect do
          non_admin.update_attributes({ admin: TRUE })
        end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end    

    end




  end


end
