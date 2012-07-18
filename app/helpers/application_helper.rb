
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
		longlink = "http://agreethepeople.com/" + agreement.topic.slug + "/?agreement=" + agreement.id.to_s
		longlink = "http://www.dailymotion.com/video/xsdji_rick-astley-never-gonna-give-you-up_music"
		bitly = Bitly.shorten(longlink)
		bitly.url #=> "http://bit.ly/le0JRh"
	end


	def shorten_with_bitly(url)
		# build url to bitly api
		user = "agrtpco"
		apikey = "R_511f8477afc56626f21dc59502a68cd3"
		version = "2.0.1"
		bitly_url = "http://api.bit.ly/shorten?version=#{version}&longUrl=#{url}&login=#{user}&apiKey=#{apikey}"
		 
		# parse result and return shortened url
		buffer = open(bitly_url, "UserAgent" => "Ruby-ExpandLink").read
		result = JSON.parse(buffer)
		short_url = result['results'][url]['shortUrl']
	end
		

	# def make_short_link
	# 	version = '0.1.5'
	# 	rest_api_url = "http://api.bit.ly"
	# 	action_path = { :shorten => '/v3/shorten', :expand => '/v3/expand', :clicks => '/v3/clicks' }
	# 	new_long_url = "http://www.dailymotion.com/video/xsdji_rick-astley-never-gonna-give-you-up_music"
	# 	login = "agrtpco"
	# 	key = "R_511f8477afc56626f21dc59502a68cd3"

	# 	response = JSON.parse RestClient.post(rest_api_url + action_path[:shorten], { :longURL => new_long_url, :login => login, :apiKey => key })

	# 	bitly = Bitly.new response["data"]

	# 	bitly.hash_path = response["data"]["hash"] if response["status_code"] == 200
	# 	bitly.status_code = response["status_code"]
	# 	bitly.status_txt = response["status_txt"]

	# 	bitly
	# end

end


