class AddTwitterImageToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :imagelink, :text
  end

  def self.down
  	drop_column :users, :imagelink
  end
end
