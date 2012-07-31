
class CreateSuggestedTopics < ActiveRecord::Migration
  def self.up
    create_table :suggested_topics do |t|
      t.text :title

      t.timestamps
    end

  end

  def self.down
  	drop_table :topics
  end
end
