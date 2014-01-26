class CreateQuestionAnswers < ActiveRecord::Migration
  def change
    create_table :question_answers do |t|
      t.integer :question_id
      t.text :answer_body, null:false
      t.timestamps
    end
  end
end
