include ActionView::Helpers::TextHelper
include TopicsHelper

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
		@agreement = generate_agreement_for unless @topic.agreements.count==0
  	end


end


