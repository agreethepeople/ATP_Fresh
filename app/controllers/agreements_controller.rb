class AgreementsController < ApplicationController
	before_filter :signed_in_user, only: [:create]

	def create
		@agreement = Agreement.create(params[:agreement])
		if @agreement.save
			flash[:success] = "Agreement created!"
		else
        	flash[:failure] = "Agreement not created."
		end
		redirect_to @agreement.topic
	end

end
