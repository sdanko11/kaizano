class EventKeyUnique < ActiveRecord::Migration
 def up
    add_index :events, :event_key, unique: true
  end
  def down
    remove_index :events, :event_key
  end
end

