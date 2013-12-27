class AddEventPassword < ActiveRecord::Migration
  def up
    add_column :events, :event_password, :string, :limit => 8, null:false
  end
  def down
    remove_column :events, :event_password
  end
end