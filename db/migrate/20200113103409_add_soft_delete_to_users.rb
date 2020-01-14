class AddSoftDeleteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :softDelete, :boolean, :default => false
  end
end
