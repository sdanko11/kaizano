class ChangeNameOfVotesTable < ActiveRecord::Migration
  def up
    rename_table :votes, :question_votes
  end
  def down
    rename_table :question_votes, :votes
  end
end
