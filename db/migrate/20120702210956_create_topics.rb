class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.text :title

      t.timestamps
    end

    add_index :topics, [:title]
  end

  def self.down
  	drop_table :topics
  end
end
