class DropIndexesFromOldUser < ActiveRecord::Migration
  def up
  	remove_index :users, :email
  	remove_index :users, :remember_token
  end

  def down
  	add_index :users, :email, unique: true
  	add_index :users, :remember_token
  end
end
