class Topic < ActiveRecord::Base
  attr_accessible :title 
  # THIS NEEDS TO BE PROTECTED FROM MASS ASSIGNMENT
  # there's a test already set up for it in topic_spec that just needs to be uncommented
  
  validates :title, presence: true

  has_many :agreements, dependent: :destroy


end
