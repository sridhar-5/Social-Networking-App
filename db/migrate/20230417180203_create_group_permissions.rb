class CreateGroupPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :group_permissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
