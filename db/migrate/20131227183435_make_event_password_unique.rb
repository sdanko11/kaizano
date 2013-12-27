class MakeEventPasswordUnique < ActiveRecord::Migration
  def up
    add_index :events, :event_password, unique: true
  end
  def down
    remove_index :events, :event_password
  end
end
