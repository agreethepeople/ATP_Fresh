class AgreementsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :admin, only: [:destroy]

	def create

		#make sure the author is the logged in user
		author = User.find_by_id(params[:agreement][:user_id])
		if !current_user?(author)
			flash[:failure] = "Incorrect author for current user"
			redirect_to root_path
			return
		end


		@agreement = Agreement.new

		if @agreement.protected_creation(params[:agreement])
			flash[:success] = "Agreement created!"
			redirect_to "/#{@agreement.topic.slug}?agreement=#{@agreement.id}"
		else
			if (@agreement.content.length > 140)
        		flash[:failure] = "Your agreement was not created because it was #{@agreement.content.length} characters long."
        	else
        		flash[:failure] = "Agreement not created."
        	end
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
