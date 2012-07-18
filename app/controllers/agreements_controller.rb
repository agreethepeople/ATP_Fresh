class AgreementsController < ApplicationController
	before_filter :signed_in_user, only: [:create]

	def create
		@agreement = Agreement.create(params[:agreement])
		if @agreement.save
			flash[:success] = "Agreement created!"
			redirect_to "/#{@agreement.topic.slug}?agreement=#{@agreement.id}"
		else
        	flash[:failure] = "Agreement not created."
        	redirect_to mainpage_path(@agreement.topic.slug)
		end
	end

end
