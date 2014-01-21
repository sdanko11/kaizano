class CreateContactForms < ActiveRecord::Migration
  def change
    create_table :contact_forms do |t|
      t.string :name
      t.string :email_address, null:false
      t.text :message, null:false
      t.string :subject, null:false
      t.timestamps
    end
  end
end
