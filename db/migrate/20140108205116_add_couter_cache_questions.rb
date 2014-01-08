class AddCouterCacheQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :question_votes_count, :integer, :default => 0
  end
  def down
    remove_column :questions, :question_votes_count
  end
end
