class VotesController < ApplicationController
	#before_filter :signed_in_user

	respond_to :html, :js

	def create
		@vote_agreement = Agreement.find(params[:votes][:voteable_id])
		@topic = @vote_agreement.topic

		if signed_in?
			@vote_user = User.find(params[:votes][:voter_id])
			value = params[:votes][:commit].to_s.downcase.to_sym
			if value == :against 
				@vote_user.vote_exclusively_against(@vote_agreement)
			else
				@vote_user.vote_exclusively_for(@vote_agreement, :value)
			end
		end
		respond_to do |format|
		  format.html { redirect_to mainpage_path(@topic.slug) }
		  format.js
		end
		#respond_with mainpage_path(@topic.slug)
		#respond_with(mainpage_path(@vote_agreement.topic.slug))
		#respond_with(@agreement)
		#respond_with(@topic.slug)
		#redirect_to mainpage_path(@topic.slug)
		#respond_with(mainpage_path(@topic.slug))
		#respond_with(@topic.slug, location: mainpage_path)
	end

end
