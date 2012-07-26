class AgreementsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :admin, only: [:destroy]

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

  	def delete
	    if current_user.admin? && Agreement.find(params[:id])
	    	topic = Agreement.find(params[:id]).topic
			Agreement.find(params[:id]).destroy
			flash[:success] = "Agreement destroyed."
			redirect_to "/#{topic.slug}/agreements"
	    end
  	end


end
