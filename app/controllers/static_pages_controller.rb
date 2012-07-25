

class StaticPagesController < ApplicationController
  	def home
		@topics = Topic.find(:all, :limit => 5)

	end

	def help
	end

	def about
	end

	def contact
	end

end
