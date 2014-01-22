class CreateEventSession < ActiveRecord::Migration
  def change
    create_table :event_sessions do |t|
      t.integer :event_id
      t.string :signed_in 
    end
  end
end
