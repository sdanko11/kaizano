class MakeEventDateNullFalse < ActiveRecord::Migration

  def up
    Event.find_each do |event|
      if event.event_date.nil?
        event.event_date = Time.now
        event.save!
      end 
    end
    change_column :events, :event_date, :date, null: false
  end

  def down
    change_column :events, :event_date, null: true
  end

end