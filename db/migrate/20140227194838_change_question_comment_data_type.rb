class ChangeQuestionCommentDataType < ActiveRecord::Migration
  
  def up
    change_column :question_comments, :body, :text
  end

  def down
    change_column :question_comments, :body, :string
  end

end
