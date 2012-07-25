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
  attr_accessible :email, :name, :password, :password_confirmation, :twitter_handle

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



     #  def vote_exclusively_for_test(voteable, importance)
     #    self.vote_test(voteable, { :direction => :up, :exclusive => true, :value => importance })
     #  end

     #  def vote_exclusively_against_test(voteable, importance=-1)
     #    self.vote_test(voteable, { :direction => :down, :exclusive => true, :value => -1 })
     #  end

     #  def unvote_for_test(voteable)
     #    Vote.where(
     #      :voter_id => self.id,
     #      :voter_type => self.class.base_class.name,
     #      :voteable_id => voteable.id,
     #      :voteable_type => voteable.class.base_class.name
     #    ).map(&:destroy)
     #  end

     # def vote_test(voteable, options = {})
     #  #       importance=:against
     #  #  self.vote(voteable, { :direction => :down, :exclusive => true, :value => importance })
     #  # :exclusive (true),
     #  # :direction (:up, :down)
     #  # :value (:high, :medium, :low, :against, :skip)
     #    raise ArgumentError, "you must specify :up or :down in order to vote" unless options[:direction] && [:up, :down].include?(options[:direction].to_sym)
     #    raise ArgumentError, "you must specify value vote" unless options[:direction] && [:up, :down].include?(options[:direction].to_sym)
     #    remember_tweet = self.tweeted?(voteable) #because the unvote will wipe it out
     #    if options[:exclusive]
     #      self.unvote_for_test(voteable)
     #    end
     #    direction = (options[:direction].to_sym == :up)
     #    weight = options[:value]
  
     #    Vote.create!(:vote => direction, :voteable => voteable, :voter => self, :value => weight, :tweeted => remember_tweet)
     #  end


end

