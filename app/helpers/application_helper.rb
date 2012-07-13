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




end


