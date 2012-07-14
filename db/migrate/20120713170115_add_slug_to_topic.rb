class AddSlugToTopic < ActiveRecord::Migration
  def change

    add_column :topics, :slug, :text, null: false, unique: true

  end
end
