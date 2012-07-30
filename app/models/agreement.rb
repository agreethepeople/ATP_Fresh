class Agreement < ActiveRecord::Base
  #attr_accessible :content, :topic_id, :user_id
  
  #TODO: add methods needed by any controllers using these attributes, e.g. create
  # content should be writeable upon create, otherwise only updated by admins
  # user_id (author) should only be updateable to anonymous
  attr_protected :content, :topic_id, :user_id

  acts_as_voteable

  belongs_to :user
  belongs_to :topic

  validates :content, presence: true, length: { maximum: 140 }
  validates :topic, presence: true

# for a link
#validates_format_of :domain_name, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix


	 def self.all_voted_on_by_user_and_topic(user, topic)
	 	# agreement_topics = "SELECT topic_id FROM agreements WHERE topic_id = :topic_id"
	 	# voted_agreements = "SELECT voteable_id FROM votes WHERE voter_id = :user_id"
	 	# all_agreements = where("id IN (#{voted_agreements}) AND topic_id IN (#{agreement_topics})", user_id: user, topic_id: topic)
	 	voted_agreements = Agreement.find_by_sql ["SELECT agreements.* FROM agreements JOIN votes v ON v.voteable_id = agreements.id WHERE v.voter_id = ? AND agreements.topic_id = ? ORDER BY v.value DESC", user.id, topic.id]
	 end

	 def self.all_written_by_user_on_topic(user, topic)
	 	#all the agreements written by a user on a topic
	 	Agreement.find_by_sql ["SELECT agreements.* FROM agreements WHERE user_id = ? AND topic_id = ? ", user.id, topic.id]
	 end


	 def protected_creation(attributes)
		self.content = attributes[:content]
		self.topic_id = attributes[:topic_id]
		self.user_id = attributes[:user_id]
		return(self.save)
	 end




end




