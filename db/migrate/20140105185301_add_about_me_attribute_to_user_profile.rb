class AddAboutMeAttributeToUserProfile < ActiveRecord::Migration
  def up
    add_column :users, :about_me, :text
  end
  def down
    remove_column :users, :about_me
  end
end
