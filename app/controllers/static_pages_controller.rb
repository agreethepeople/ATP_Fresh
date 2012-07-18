

class StaticPagesController < ApplicationController
  	def home
		@topics = Topic.find(:all, :limit => 5)

		user = "agrtpco" 
		apikey = "R_511f8477afc56626f21dc59502a68cd3" 
		longurl = "http://www.dailymotion.com/video/xsdji_rick-astley-never-gonna-give-you-up_music" 
		@link = Bitly.shorten(longurl, user, apikey).url  if Rails.env.production?
		@link ||= "not on production"
	end

	def help
	end

	def about
	end

	def contact
	end
  
end
