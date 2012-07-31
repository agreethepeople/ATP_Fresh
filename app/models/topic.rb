class Topic < ActiveRecord::Base
  #attr_accessible :title, :slug
  # THIS NEEDS TO BE PROTECTED FROM MASS ASSIGNMENT
  # there's a test already set up for it in topic_spec that just needs to be uncommented
  #TODO: add methods needed by any controllers using these attributes, e.g. create
  attr_protected :title, :slug
  
  validates :title, presence: true
  validates :slug, presence: true

  has_many :agreements, dependent: :destroy


	def self.all_of_interest_to(user)
    #all of the topics a user has voted on agreements under
		interested_topics = "SELECT id FROM topics WHERE id IN ( SELECT topic_id FROM agreements WHERE id  IN ( SELECT voteable_id FROM votes WHERE voter_id = :user_id))"
		where("id IN (#{interested_topics})", user_id: user)
	end

  def self.all_written_to(user)
    #all of the topics a user has written posts under
    interested_topics = "SELECT id FROM topics WHERE id IN ( SELECT topic_id FROM agreements WHERE agreements.user_id = :user_id )" 
    where("id IN (#{interested_topics})", user_id: user)
  end

  def make_safe_topic(title)
    self.title = title
    self.slug = title.strip.downcase.gsub(/ /,'-')
    return(self.save)
  end


end