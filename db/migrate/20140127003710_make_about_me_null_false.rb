class MakeAboutMeNullFalse < ActiveRecord::Migration
  
  def up
    
    User.find_each do |user|
      if user.about_me == nil
        user.about_me = "#{user.first_name} #{user.last_name}, has not updated there about me section."
        user.save!
      end 
    end

    change_column :users, :about_me, :text, null: false

  end

  def down
    change_column :users, :about_me, :text, null: true
  end

end
