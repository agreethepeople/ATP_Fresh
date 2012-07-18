
module ApplicationHelper

	#returns the title on a per-page basis
	def full_title(page_title)
		base_title = "Agree the People"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end


	def short_link_for_agreement(agreement)
		user = "agrtpco"
		apikey = "R_511f8477afc56626f21dc59502a68cd3"

		longlink = "http://#{request.host}:#{request.port.to_s + request.fullpath}"
		longlink = longlink + agreement.topic.slug + "/?agreement=" + agreement.id.to_s
		longlink = "http://www.dailymotion.com/video/xsdji_rick-astley-never-gonna-give-you-up_music"
#		shorturl = Bitly.shorten(longlink) if Rails.env.production?
#		return_this = shorturl.url if Rails.env.production?
		return_this ||= "http://agrtp.co/MsUNJL"
	end

end


