class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body, null:false
      t.integer :event_id
      t.timestamps
    end
  end
end
