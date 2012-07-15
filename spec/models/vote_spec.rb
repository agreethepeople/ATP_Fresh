require 'spec_helper'

describe Vote do

	let(:user) { FactoryGirl.create(:user) }
	let(:topic) { FactoryGirl.create(:topic) }
	let!(:agreement) { FactoryGirl.create(:agreement, user: user, topic: topic) }
	let!(:vote) { FactoryGirl.create(:vote, 
		voteable_type: :agreement, voteable_id: agreement.id, voter_id: user.id) }
	
	subject { vote }

	it { should respond_to(:vote) }
	it { should respond_to(:voter) }
	it { should respond_to(:voteable) }
	it { should respond_to(:voteable_id) }
	it { should respond_to(:value) }
	it { should respond_to(:tweeted) }
	it { should be_valid }


	# make users
	# have them vote differently
	# count the votes that come out

	describe "some basic functions of voting" do
		let(:tweeter) { FactoryGirl.create(:user) }
		let!(:agreer) { FactoryGirl.create(:user) }
		let!(:strong_agreer) { FactoryGirl.create(:user) }
		let!(:disagreer) { FactoryGirl.create(:user) }
		let!(:skipper) { FactoryGirl.create(:user) }
		let!(:new_agreement) { FactoryGirl.create(:agreement, user: user, topic: topic) }

		before do
			tweeter.tweet_for(new_agreement)
			skipper.vote_exclusively_for(new_agreement, :skip)
			disagreer.vote_exclusively_against(new_agreement, :against)
			strong_agreer.vote_exclusively_for(new_agreement, :high)
			strong_agreer.tweet_for(new_agreement)
			agreer.vote_exclusively_for(new_agreement, :low)
		end

		it "should have 2 agrees" do
        	new_agreement.votes_for == 2
     	end
  		it "should have 1 disagree" do
         	new_agreement.votes_against == 1
     	end
   		it "should have 1 skip" do
         	new_agreement.votes_skipped == 1
     	end
     	it "should have 2 tweets" do
     		#agreer.get_tweeted(new_agreement)==1
     		strong_agreer.tweeted?(new_agreement)==TRUE
     		tweeter.tweeted?(new_agreement)==TRUE
     		new_agreement.tweets_for==2
     	end
     	it "should have 1 high" do
     		strong_agreer.voted_high?(new_agreement)==TRUE
     		agreer.voted_high?(new_agreement)==FALSE
     		disagreer.voted_high?(new_agreement)==FALSE
     	end
     	it "should have 1 low" do
     		strong_agreer.voted_low?(new_agreement)==FALSE
     		agreer.voted_low?(new_agreement)==TRUE
     		disagreer.voted_low?(new_agreement)==FALSE
     	end
     	it "should have 0 mediums" do
     		new_agreement.votes_medium == 0
     	end

     	describe "voting after tweeting" do
     		before do
     			tweeter.vote_exclusively_for(new_agreement, :medium)
     		end
	     	it "should have 1 mediums" do
	     		new_agreement.votes_medium == 1
	     	end
	    end


	    describe "changing a vote" do
	    	before do
				agreer.vote_exclusively_for(new_agreement, :medium)
	    	end

	    	it "should have 2 agrees, 1 dis, 0 low, 1 med, 1 high, 1 skip, 1 tweet" do
        		new_agreement.votes_for == 2
        		new_agreement.votes_against == 1
        		new_agreement.votes_low == 0
        		new_agreement.votes_medium == 0
        		new_agreement.votes_high == 0
        		new_agreement.votes_skipped == 0
        		new_agreement.tweets_for == 1

	    	end
	    end 

	end



end

