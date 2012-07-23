# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'
require 'iconv'

open("./db/topics.txt") do |topics|
	topics.read.each_line do |topic|
		title = topic.strip
		slug = title.gsub(/ /, '-').gsub(/\./,'').downcase
		this_topic = Topic.find_or_create_by_title_and_slug(title, slug)
	end
end


open("./db/abortion.txt") do |agreements|
	topic = Topic.find_or_create_by_slug('abortion')
	agreements.read.each_line do |agree|
		agree.strip!
		Agreement.create!(content: agree, user_id: 1, topic_id: topic.id)
	end
end



#ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
open("./db/nycsoda.txt") do |agreements|
	topic = Topic.find_or_create_by_slug('nyc-soda-restriction')
	agreements.read.each_line do |agree|
		agree.strip!
		#valid_string = ic.iconv(agree)
		Agreement.create!(content: agree, user_id: 1, topic_id: topic.id)
	end
end


ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
open("./db/gaymarriage.txt") do |agreements|
	topic = Topic.find_or_create_by_slug('gay-marriage')
	agreements.read.each_line do |agree|
		valid_string = ic.iconv(agree)
		valid_string.strip!
		Agreement.create!(content: valid_string, user_id: 1, topic_id: topic.id)
	end
end









# ["Windows", "Linux", "Mac OS X"].each do |os|



#   Topic.find_or_create_by_slug(os)
# end

# Country.delete_all
# open("http://openconcept.ca/sites/openconcept.ca/files/country_code_drupal_0.txt") do |countries|
#   countries.read.each_line do |country|
#     code, name = country.chomp.split("|")
#     Country.create!(:name => name, :code => code)
#   end
# end

