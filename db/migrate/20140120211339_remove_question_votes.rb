class RemoveQuestionVotes < ActiveRecord::Migration
  def up
    drop_table :question_votes
  end
  def down
    create_table :question_votes
  end
end
