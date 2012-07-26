

class StaticPagesController < ApplicationController
  	def home
		@topics = Topic.find(:all)
	end

	def help
	end

	def about
	end

	def contact
	end

end
