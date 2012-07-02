class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :title

      t.timestamps
    end

    add_index :topics, [:title]
  end
end
