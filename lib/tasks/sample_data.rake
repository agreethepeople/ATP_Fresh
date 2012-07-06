namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_topics
		make_agreements
	end
end


def make_users
	admin = User.create!(name: "Alex Gessner",
		email: "alex.gessner@gmail.com",
		password: "foobar",
		password_confirmation: "foobar")
	admin.toggle!(:admin)
	
	99.times do |n|
		name = Faker::Name.name
		email = "example-#{n+1}@example.com"
		password = "password"
		User.create!(name: name, 
					email: email,
					password: password,
					password_confirmation: password)
	end
end



def make_topics
	50.times do
		title = Faker::Lorem.sentence(3)
		Topic.create!(title: title)
	end
end


def make_agreements
	users = User.all(limit: 5)
	topics = Topic.all
	users.each { |user| 
		topics.each { |topic| 
			content = Faker::Lorem.sentence(7)
			Agreement.create!(content: content, topic_id: topic.id, user_id: user.id)
		}
	}
end


