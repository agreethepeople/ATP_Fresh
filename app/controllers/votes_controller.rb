class VotesController < ApplicationController
	#before_filter :signed_in_user

	respond_to :html, :js

	def create
		puts params

		@vote_agreement = Agreement.find(params[:votes][:voteable_id])
		@topic = @vote_agreement.topic

		if signed_in?
			@vote_user = User.find(params[:votes][:voter_id])
			case params[:commit]
			when "Trivial"
				value = :low
			when "Relevant"
				value = :medium
			when "Essential"
				value = :high
			when LOW
				value = :low
			when MEDIUM
				value = :medium
			when HIGH
				value = :high
			when "Disagree"
				value = :against
			when "Skip"
				value = :skip
			end

			if value == :against
				@vote_user.vote_exclusively_against(@vote_agreement, value)
			else
				@vote_user.vote_exclusively_for(@vote_agreement, value)
			end
		end
		respond_to do |format|
		  format.html { redirect_to mainpage_path(@topic.slug) }
		  format.js { } 
		end

	end


end
