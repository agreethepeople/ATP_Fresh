class Agreement < ActiveRecord::Base
  attr_accessible :content, :topic_id, :user_id
  #i'm pretty sure these need to be protected somehow

  acts_as_voteable

  belongs_to :user
  belongs_to :topic

  validates :content, presence: true, length: { maximum: 140 }
  validates :topic, presence: true


	 def self.all_voted_on_by_user_and_topic(user, topic)
	 	agreement_topics = "SELECT topic_id FROM agreements WHERE topic_id = :topic_id"
	 	voted_agreements = "SELECT voteable_id FROM votes WHERE voter_id = :user_id"
	 	all_agreements = where("id IN (#{voted_agreements}) AND topic_id IN (#{agreement_topics})", user_id: user, topic_id: topic)

	 end


# SELECT agreements.*, votes.b2_value FROM agreements, votes JOIN on voteable_id = agreement.id 
# WHERE 
	
		# agreements_and_votes = all_agreements.find(:all, :joins => "INNER JOIN votes ON votes.voteable_id = agreements.id")
		
		# SELECT agreements.*, votes.value FROM agreements, votes 
		# WHERE agreements.id = voteable_id AND agreements.id IN (#{all_agreements.id})

		# agreements_and_votes = find(:all, 
		# 					:joins => "INNER JOIN votes ON votes.voteable_id = :all_agreements.id",
		# 					:conditions => {}
		# 					)



		# puts agreements_and_votes


# foo = a.find(:all, 
#        :joins => [:b, :c], 
#        :select => "distinct b.b2 as b2_value, c.c2 as c2_value", 
#        :conditions => {:a => {:a1 => Time.now.midnight. ... Time.now}}, 
#        :group => "b.b2, c.c2") 



	 def self.all_voted_on_by_user(user)
	 	agreements = Agreement.where(user_id: user.id)
	 end

end




