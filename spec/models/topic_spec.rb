require 'spec_helper'

describe Topic do
  
	before do
		#let(:topic) { FactoryGirl.create(:topic) }
		@topic = Topic.new(title: "Twilight Heroes")
	end
	
	subject { @topic }

	it { should be_valid }
	it { should respond_to(:title) }

	describe "accessible attributes" do
		it "should not allow access to title" do
#			expect do
#				Topic.new(title: "Any old title")
#			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

end
