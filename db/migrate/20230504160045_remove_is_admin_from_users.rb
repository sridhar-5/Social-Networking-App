class RemoveIsAdminFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :isAdmin, :boolean
    add_column :users, :role, :integer, default: 94907
  end
end
