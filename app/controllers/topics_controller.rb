include ActionView::Helpers::TextHelper


class TopicsController < ApplicationController
	def index
		#all the topics
    	@topics = Topic.paginate(page: params[:page])
  	end

  	def show
  		#one topic main page
		@topic = Topic.find(params[:id])
		@agreement = GiveMeAnAgreementFor(@topic) unless @topic.agreements.count==0
  	end


  	private

		def GiveMeAnAgreementFor(topic)
			#take user and topic and give an agreement to vote on
			#agreement should belong to the topic and be one that the user has not already voted on
			#simple for now. we'll make it better later
			topic.agreements.sample
		end

end


