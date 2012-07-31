#require 'ruby-bitly'
include VotesHelper
include UsersHelper

module TopicsHelper



	def generate_agreement_for
		topic = @topic

		#take user and topic and give an agreement to vote on
		#agreement should belong to the topic and be one that the user has not already voted on
		#simple for now. we'll make it better later
		
		return topic.agreements.sample if !signed_in?
		topic.agreements.each do |i|
		 	agreement_to_return = topic.agreements.sample 
		 	return agreement_to_return unless agreement_to_return.voted_by?(current_user)
		 	agreement_to_return = topic.agreements.sample 
			return agreement_to_return unless agreement_to_return.voted_by?(current_user)			
		end
		return topic.agreements.sample
	end



	def agreements_left_in_topic_for_user(user, topic)
		if (user && topic)
			left_in_topic = topic.agreements.count - Agreement.joins('INNER JOIN votes ON votes.voteable_id = agreements.id').where('voter_id=? AND topic_id=?', user.id, topic.id).count
		end
	end

	def votes_for_a_topic(topic)
		return topic.total_votes_for
	end

	def current_vote_for_helper(user, agreement)
		return user.current_vote_on(agreement)
	end

	def number_of_agreements_for_user(user)
		Agreement.joins('INNER JOIN votes ON votes.voteable_id = agreements.id').where('voter_id=? AND topic_id=? AND votes.value > 0', user.id, @topic.id).count
	end

end