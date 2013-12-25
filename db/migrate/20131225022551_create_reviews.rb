class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :feedback_comments
      t.integer :rating, null:false 
      t.integer :event_id
      t.timestamps
    end
  end
end
