include AuthenticationsHelper


class AuthenticationsController < ApplicationController
#include AuthenticationsHelper


	def new
		redirect_to '/auth/twitter'
	end


	def create
		#this brings up a 401 error if the user hits cancel on the twitter page. not sure how to fix.
		auth = request.env["omniauth.auth"]
		handle = auth['info']['nickname']

		user = User.find_or_create_by_twitter_handle(handle)
		user.name = auth['info']['name']
			#update anything else the user may have changed on their twitter profile
			#maybe picture? whatevs
		user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
		user.email = "replace-me-please@example.com" if !user.valid?
		user.save!
		flash[:success] = "Welcome, #{user.twitter_handle}."
		#@current_user = user
		#session[:user_id] = user.id
		sign_in(user)
		#current_user= user
		redirect_to root_path
	end

	def destroy
		@authentication = current_user.authentications
		@authentication.destroy
		sign_out
		flash[:success] = "Successfully logged out. Come back soon, ya hear."
		redirect_to root_path
	end

end
