include ActionView::Helpers::TextHelper


class TopicsController < ApplicationController
	def index
    	@topics = Topic.paginate(page: params[:page])
  	end

	def hot
		#@topics = User.find(params[:id])
	end


  	def show
		@topic = Topic.find(params[:id])
  	end

end
