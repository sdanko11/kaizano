class ChangeEventTimeFormat < ActiveRecord::Migration
  def up
    change_column :events, :event_date, :datetime
  end

  def down
    change_column :events, :event_date, :date
  end

end
