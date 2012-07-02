require 'spec_helper'


describe "Topic pages" do

	subject { page }

	describe "All sitewide topics page" do

		before do
			visit all_path
		end
		let(:topic1) { FactoryGirl.create(:topic) }
		let(:topic2) { FactoryGirl.create(:topic) }


		it { should have_content('All Sitewide Topics') }
		#it { should have_content(topic1.title) }

	end
end
