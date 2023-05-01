class UpdateForeignKeyOnGroupsTable < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :groups, :users
    add_foreign_key :groups, :users, on_delete: :cascade
  end
end
