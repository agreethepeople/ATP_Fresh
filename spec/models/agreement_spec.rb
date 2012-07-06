require 'spec_helper'

describe Agreement do


# 3. create with a user but no topic - ERROR
# 4. create with no user but a topic - username defaults to Anonymous
# 6. delete a user and see the agreement change to Anonymous


	let(:user) { FactoryGirl.create(:user) }
	let(:topic) { FactoryGirl.create(:topic) }
	let!(:agreement) { FactoryGirl.create(:agreement, user: user, topic: topic) }

	subject { agreement }


	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	it { should respond_to(:topic_id) }
	it { should respond_to(:topic) }
	it { should be_valid }

	describe "with content that is too long" do
		before { agreement.content = "a" * 131 }
		it { should_not be_valid }
	end

	describe "when topic_id is not present" do
		before { agreement.topic_id = nil }
		it { should_not be_valid }
	end

    it "should cascade delete with topic" do
    	agreements = topic.agreements
    	topic.destroy
    	agreements.each do |agreement|
    		Agreement.find_by_id(agreement.id).should be_nil
    	end
    end

end
