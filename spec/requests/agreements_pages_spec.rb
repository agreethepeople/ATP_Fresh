require 'spec_helper'


# log in (verify message and correct page)
# see all issues (verify the issues are there)
# click on the first one (verify on the right page)
# add an agreement (verify flash message)
# go to the user profile page (verify correct page)
# verify the added agreement is on that page too


describe "Full Agreement Workflow" do

	let!(:user) { FactoryGirl.create(:user) }
	let!(:topic) { FactoryGirl.create(:topic, title: "Edward v. Jacob", slug: "edward-v-jacob") }
	let!(:agreement1) { FactoryGirl.create(:agreement, user: user, topic: topic) }
  let!(:agreement2) { FactoryGirl.create(:agreement, user: user, topic: topic) }

	subject { page }

	describe "valid log in" do
		  before { valid_signin(user) }
    	it { should be_logged_in }

    	describe "go to all issues page" do
    		before do
    			click_link "See all of the issues"
    		end
    		it { should have_content "All Sitewide Topics" }
			  it { should be_logged_in }
        it { should have_content(topic.title) }

        	describe "open up the issue" do
        		before do
        			click_link topic.title
        		end
        		it { should have_content(topic.title) }
        		it { should have_content("Agreements") }
        		it { should be_logged_in }

            it "should have 2 agreements right here" do
              topic.agreements.count == 2
            end


        		describe "Add an agreement" do
        			before do
        				fill_in "agreement_content",    with: "who wouldn't agree with this?"
        				click_button "Submit"
        			end

      				it { should have_selector('div.alert.alert-success', text: 'Agreement created!') }
      				it { should be_logged_in }

      				describe "Find the agreement on the user profile page" do
      					before do
      						click_link "view my profile"
      					end
      					it { should have_content("who wouldn't agree with this?") }
      					it { should have_content(user.name) }
      					it { should be_logged_in }
      				end

      			end
        	end
		  end
    end
end




