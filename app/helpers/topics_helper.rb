
module TopicsHelper

	def generate_agreement_for
		topic = @topic
		#take user and topic and give an agreement to vote on
		#agreement should belong to the topic and be one that the user has not already voted on
		#simple for now. we'll make it better later
		return topic.agreements.sample unless current_user 
		topic.agreements.each do |agreement|
			return agreement unless agreement.voted_by?(current_user)
		end
		topic.agreements.sample
	end

end