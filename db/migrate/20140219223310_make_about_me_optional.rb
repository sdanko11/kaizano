class MakeAboutMeOptional < ActiveRecord::Migration
  
  def up
    change_column :users, :about_me, :text, null: true
  end

  def down
    change_column :users, :about_me, :text, null: false
  end

end
