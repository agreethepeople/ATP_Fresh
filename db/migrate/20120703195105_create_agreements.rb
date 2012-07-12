class CreateAgreements < ActiveRecord::Migration
  def self.up
    create_table :agreements do |t|
      t.text :content
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
  end



  def self.down
    drop_table :agreements
  end

end
