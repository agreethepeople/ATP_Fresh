# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#



class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :twitter_handle, :admin

  has_many :agreements
  has_many :authentications

  acts_as_voter

#  has_secure_password
  before_save { self.email.downcase! }


  validates :name, length: { maximum: 50 }, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, #presence: true, 
  		format: { with: VALID_EMAIL_REGEX }#, 
 # 		uniqueness: { case_sensitive: false }


#  validates :password, length: { minimum: 6 }
#  validates :password_confirmation, presence: true


#  before_save :create_remember_token

  # private
  #   def create_remember_token
  #     self.remember_token = SecureRandom.urlsafe_base64
  #   end


    def current_vote_on(agreement)
      return nil unless self.voted_on?(agreement)
      return "#{LOW} Important" if self.voted_low?(agreement)
      return "#{MEDIUM} Important" if self.voted_medium?(agreement)
      return "#{HIGH} Important" if self.voted_high?(agreement)
      return "Disagree" if self.voted_against?(agreement)
      return "Skip" if self.voted_skip?(agreement)
    end


    def points
      user_agreements = Vote.where("voter_id = ? AND value > 0", self.id).count
      authored_agreements = "SELECT id FROM agreements WHERE user_id = :author"
      votes_generated = Vote.where("voteable_id IN (#{authored_agreements}) AND value > 0 AND voter_id != :author", author: self.id).count
      total_points = user_agreements + votes_generated
    end


end

