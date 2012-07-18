# FactoryGirl.define do
# 	factory :user do
# 		name					"Michael Hartl"
# 		email					"michael@example.com"
# 		password				"foobar"
# 		password_confirmation	"foobar"
# 	end
# end

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    sequence(:twitter_handle) { |n| "person-#{n}" }


    factory :admin do
    	admin true
    end

  end

  factory :topic do
    sequence(:title)  { |n| "TITLE number #{n}" }
    sequence(:slug) { |n| "title-number-#{n}" }
  end

  factory :agreement do
    # need to pass this a user and a topic object
    sequence(:content)  { |n| "Luv 4 Edward Cullen times" }
  end

  factory :vote do
    # need to pass this a user and a topic object
    vote true
    value 10
    tweeted 0
  end


end

