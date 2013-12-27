class AddEventKeyToUsers < ActiveRecord::Migration
  def up
    remove_index :events, :event_key, unique: true
  end
  def down
    remove_index :events, :event_key
  end
end
