class CreateQuestionComments < ActiveRecord::Migration
  def change
    create_table :question_comments do |t|
      t.string :body, null:false
      t.integer :question_id
      t.timestamps
    end
  end
end
