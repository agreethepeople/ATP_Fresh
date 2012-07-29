class Authentication < ActiveRecord::Base
  #attr_accessible :provider, :uid, :user_id
  #TODO: add methods needed by any controllers using these, e.g. create
  attr_protected :provider, :uid, :user_id

  belongs_to :user

  
end
