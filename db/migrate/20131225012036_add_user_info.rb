class AddUserInfo < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null:false
    add_column :users, :twitter_handle, :string
    add_column :users, :linked_in_url, :string
    add_column :users, :phone_number, :string
  end
  def down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :twitter_handle
    remove_column :users, :linked_in_url
    remove_column :users, :phone_number
  end

end
