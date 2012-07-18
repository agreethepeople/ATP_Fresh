class Agreement < ActiveRecord::Base
  attr_accessible :content, :topic_id, :user_id
  #i'm pretty sure these need to be protected somehow

  acts_as_voteable

  belongs_to :user
  belongs_to :topic

  validates :content, presence: true, length: { maximum: 130 }
  validates :topic, presence: true

	 def self.all_voted_on_by_user_and_topic(user, topic)
	 	
	 	 

	 	agreement_topics = "SELECT topic_id FROM agreements WHERE topic_id = :topic_id"
	 	voted_agreements = "SELECT voteable_id FROM votes WHERE voter_id = :user_id"
	 	where("id IN (#{voted_agreements}) AND topic_id IN (#{agreement_topics})", user_id: user, topic_id: topic)


	 # 	interested_topics = "SELECT id FROM topics WHERE id IN ( SELECT topic_id FROM agreements WHERE id  IN ( SELECT voteable_id FROM votes WHERE voter_id = :user_id))"
		# where("id IN (#{interested_topics})", user_id: user)



	 	#agreements = Agreement.where(user_id: user.id, topic_id: topic.id)
	 end

	 def self.all_voted_on_by_user(user)
	 	agreements = Agreement.where(user_id: user.id)
	 end

end




