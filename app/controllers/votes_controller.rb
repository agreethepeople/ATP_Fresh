class VotesController < ApplicationController
	before_filter :signed_in_user

	respond_to :html, :js

	def create
		@agreement = Agreement.find(params[:votes][:voteable_id])
		@user = User.find(params[:votes][:voter_id])
		value = params[:votes][:commit].to_s.downcase.to_sym
		@topic = @agreement.topic
		if value == :against 
			@user.vote_exclusively_against(@agreement)
		else
			@user.vote_exclusively_for(@agreement, :value)
		end
		respond_with @topic
	end

end
