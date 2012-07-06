class Agreement < ActiveRecord::Base
  attr_accessible :content, :topic_id, :user_id
  #i'm pretty sure these need to be protected somehow


  belongs_to :user
  belongs_to :topic

  validates :content, presence: true, length: { maximum: 130 }
  validates :topic, presence: true


end
