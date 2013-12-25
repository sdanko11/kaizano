class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null:false
      t.string :location 
      t.string :event_url
      t.string :description, null:false
      t.integer :user_id
      t.datetime :time
      t.datetime :event_date
      t.timestamps
    end
  end
end
