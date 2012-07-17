namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_topics
		make_agreements
		make_votes
	end
end


def make_users
	admin = User.create!(name: "Alex Gessner",
		email: "alex.gessner@gmail.com",
		twitter_handle: "xgess")
	admin.toggle!(:admin)
	
	20.times do |n|
		name = Faker::Name.name
		email = "example-#{n+1}@example.com"
		twitter_handle = name.gsub(/ /, '-').downcase
		User.create!(name: name, 
					email: email,
					twitter_handle: twitter_handle)
	end
end



def make_topics
	20.times do
		title = Faker::Lorem.sentence(3)
		slug = title.gsub(/ /, '-').gsub(/\./,'').downcase
		Topic.create!(title: title, slug: slug)
	end
end


def make_agreements
	users = User.all(limit: 15)
	topics = Topic.all
	users.each { |user| 
		topics.each { |topic| 
			content = Faker::Lorem.sentence(7)
			Agreement.create!(content: content, topic_id: topic.id, user_id: user.id)
		}
	}
end


def make_votes
	users = User.all(limit:5)
	agreements = Agreement.all(limit:20)
	users.each { |user|
		agreements.each { |agreement|
			Vote.create!(:vote => :up, :voteable => agreement, :voter => user, :value => 10)
		}
	}
end

