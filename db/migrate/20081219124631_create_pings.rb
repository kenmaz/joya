class CreatePings < ActiveRecord::Migration
  def self.up
    create_table :pings do |t|
      t.float :la
      t.float :ln
      t.string :uid
			t.integer :count
			t.string :nickname
      t.timestamps
    end
  end

  def self.down
    drop_table :pings
  end
end
