require 'spec_helper'


describe "Full Voting Workflow" do

  let(:topic) { FactoryGirl.create(:topic, title: "Edward v. Jacob") }
  let(:writer1) { FactoryGirl.create(:user, name: "Martin Van Buren") }
  let!(:writer2) { FactoryGirl.create(:user, name: "William Henry Harrison") }

  let!(:agreement1) { FactoryGirl.create(:agreement, user: writer1, topic: topic) }

  let!(:tweeter) { FactoryGirl.create(:user) }
  let!(:agreer) { FactoryGirl.create(:user) }
  let!(:strong_agreer) { FactoryGirl.create(:user) }
  let!(:disagreer) { FactoryGirl.create(:user) }
  let!(:skipper) { FactoryGirl.create(:user) }

  subject { page }

  describe "agreer agreeing" do
    before do
      valid_signin(agreer)
      visit topics_path
      click_link topic.title
      #visit topics_path(topic)
    end
    it { should be_logged_in }
    it { should have_content topic.title }
    it { should have_content agreement1.content }

  
    let!(:agreement2) { FactoryGirl.create(:agreement, user: writer2, topic: topic) }

    it "should have be ready for agreeing / disagreeing / skipping" do
      topic.agreements == 2
      agreement1.votes_for == 0
      page.should have_content writer1.name
    end

    describe "making the first agreement" do
        
        before { click_button 'Low' }

        it "should increase the agrees and the lows" do
          agreement1.votes_for == 1
          agreement1.votes_low == 1
          agreer.voted_for?(agreement1)==true
          agreer.voted_low?(agreement1)==true
        end
        it "should bring up a new agreement" do
          page.should have_content agreement2.content
          page.should have_content agreement2.user.name
        end
    end
  end

  describe "disagreer disagreeing" do
    before do
      valid_signin(disagreer)
      visit topics_path
      click_link topic.title
      #visit topics_path(topic)
    end
    let!(:agreement2) { FactoryGirl.create(:agreement, user: writer2, topic: topic) }
    before { click_button 'Disagree' }
    it "should increase the disagrees" do
      agreement1.votes_against == 1
      disagreer.voted_against?(agreement1) == true
    end
    it "should bring up a new agreement" do
      page.should have_content agreement2.user.name
      page.should have_content agreement2.content
    end
  end


  describe "skipper skipping" do
    before do
      valid_signin(skipper)
      visit topics_path
      click_link topic.title
      #visit topics_path(topic)
    end
    let!(:agreement2) { FactoryGirl.create(:agreement, user: writer2, topic: topic) }
    before { click_button 'Skip' }
    it "should increase the skips" do
      agreement1.votes_skipped == 1
      skipper.voted_skip?(agreement1) == true
    end
    it "should bring up a new agreement" do
      page.should have_content agreement2.user.name
      page.should have_content agreement2.content
    end
  end
end






