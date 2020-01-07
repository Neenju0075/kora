class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users ,:email ,:string
    add_column :users ,:role ,:string
    add_index :users, :name, unique: true
  end
end
