class ChangeFeedbackCommentsDataType < ActiveRecord::Migration
  def up
    change_column :reviews, :feedback_comments, :text
  end

  def down
    change_column :reviews, :feedback_comments, :string
  end
end
