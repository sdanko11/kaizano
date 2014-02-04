class CreateMultiChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :multi_choice_questions do |t|
      t.string :question_body, null: false
      t.integer :event_id, null: false
      t.text :answer_a, null: false
      t.text :answer_b, null: false
      t.text :answer_c, null: false
      t.text :answer_d, null: false
      t.string :answer, null: false
      t.timestamps
    end
  end
end
