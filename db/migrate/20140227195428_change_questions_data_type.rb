class ChangeQuestionsDataType < ActiveRecord::Migration
  
  def up
    change_column :questions, :body, :text
  end

  def down
    change_column :questions, :body, :string
  end

end
