
module TopicsHelper



	def generate_agreement_for
		topic = @topic

		#take user and topic and give an agreement to vote on
		#agreement should belong to the topic and be one that the user has not already voted on
		#simple for now. we'll make it better later
		
		# return topic.agreements.sample if !signed_in?
		# topic.agreements.each do |i|
		#  	agreement_to_return = topic.agreements.sample 
		#  	return agreement_to_return unless agreement_to_return.voted_by?(current_user)
		#  	agreement_to_return = topic.agreements.sample 
		# 	return agreement_to_return unless agreement_to_return.voted_by?(current_user)			
		# end
		return topic.agreements.sample
	end

end