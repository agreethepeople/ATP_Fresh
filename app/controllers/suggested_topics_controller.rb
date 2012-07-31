class SuggestedTopicsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy, :index]
	before_filter :admin_user, only: [:destroy, :index]



	def create
		# any signed in user can do this, handled in the topics controller though
		puts params
		suggestion = SuggestedTopic.new(title: params[:suggested_topic][:title])
		if suggestion.save
			flash[:success] = "Thanks for the suggestion!"
		else
			flash[:failure] = "Something went wrong with that there. Sorry. "
		end
		redirect_to topics_path
	end


	def index
		@suggested_topics = SuggestedTopic.paginate(page: params[:page])
#		@topic = Topic.new
	end



	def destroy
		kill_it = SuggestedTopic.find(params[:id])
		kill_it.destroy
		redirect_to suggested_topics_path
	end


	private

	    def admin_user
	      redirect_to(root_path) unless current_user.admin?
	    end

end
