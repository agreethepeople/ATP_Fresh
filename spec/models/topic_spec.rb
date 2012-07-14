require 'spec_helper'

describe Topic do
  
	before do
		#@topic = Topic.new(title: "Twilight Heroes")
	end
	
	let(:topic) { FactoryGirl.create(:topic) }

	subject { topic }

	it { should be_valid }
	it { should respond_to(:title) }

	describe "make topic with FactoryGirl" do
		
		let!(:old_topic) do
			FactoryGirl.create(:topic, title:'TITLE OLD', slug: 'title-old', created_at: 1.day.ago)
		end
		let!(:new_topic) do
			FactoryGirl.create(:topic, title:'NEW TOPIC', slug: 'new-title', created_at: 1.hour.ago)
		end

		#### there should be a SHOULD statement in here

	end


	describe "accessible attributes" do
		it "should not allow access to title" do
#			expect do
#				Topic.new(title: "Any old title")
#			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

end
