class ChangeMultiChoiceQuestionBodyToText < ActiveRecord::Migration
  
  def up
    change_column :multi_choice_questions, :question_body, :text
  end

  def down
    change_column :multi_choice_questions, :question_body, :string
  end

end