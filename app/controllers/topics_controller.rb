include ActionView::Helpers::TextHelper


class TopicsController < ApplicationController
	def index
		#all the topics
    	@topics = Topic.paginate(page: params[:page])
  	end

  	def show
  		#one topic main page
  		#@user = User.find(params[:id]) #i'm not positive this is pulling the correct user
  		@user = current_user   #maybe this will work better
		@topic = Topic.find(params[:id])
		@agreement = GiveMeAnAgreementFor(@topic) unless @topic.agreements.count==0
  	end



  	private

		def GiveMeAnAgreementFor(topic)
			#take user and topic and give an agreement to vote on
			#agreement should belong to the topic and be one that the user has not already voted on
			#simple for now. we'll make it better later
			topic.agreements.each do |agreement|
				return agreement unless agreement.voted_by?(current_user)
			end
			topic.agreements.sample
		end

end


