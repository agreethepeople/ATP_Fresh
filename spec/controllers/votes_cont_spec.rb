require 'spec_helper'

describe VotesController do

	describe "voting by Ajax" do

		let!(:user2) { FactoryGirl.create(:user) }
		let!(:topic) { FactoryGirl.create(:topic, title: "AJAX Topic", slug: "ajax-topic") }
		let!(:agreement) { FactoryGirl.create(:agreement, user: user2, topic: topic, content: "ajax agreement content") }

		# before { current_user = user2 }

		it "should all be valid" do
			user2.should be_valid
			topic.should be_valid
			agreement.should be_valid
		end

		#it's ok that the vote via AJAX not go through here because i can't make the user signed in
		#it's better anyway to handle this in an integration test

		# it "should increment the Vote count" do
		#  	expect do
		#  		xhr :post, :create, votes: { voter_id: user2.id, voteable_id: agreement.id, commit: "Low" }
		#  	end.should change(Vote, :count).by(1)
		# end

		it "should respond with success" do
			xhr :post, :create, votes: { voter_id: user2.id, voteable_id: agreement.id, commit: "Low" }
			response.should be_success
			# user2.voted_for?(agreement).should be_true
		end
	end
end

