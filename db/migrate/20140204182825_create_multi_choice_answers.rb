class CreateMultiChoiceAnswers < ActiveRecord::Migration
  def change
    create_table :multi_choice_answers do |t|
      t.string :answer_submission, null: false
      t.integer :multi_choice_question_id, null: false
      t.timestamps
    end
  end
end
