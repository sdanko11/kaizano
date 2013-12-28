class MakeDateRequiredForEvents < ActiveRecord::Migration
  def up
    change_column :events, :event_date, :datetime, null:false
  end
  def down
    change_column :events, :event_date, :datetime, null:true
  end
end
