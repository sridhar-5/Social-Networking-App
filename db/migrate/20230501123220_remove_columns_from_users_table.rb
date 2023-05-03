class RemoveColumnsFromUsersTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :current_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_at
    remove_column :users, :last_sign_in_ip
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    remove_column :users, :failed_attempts
    remove_column :users, :unlock_token
    remove_column :users, :locked_at
    remove_column :users, :remember_created_at
    remove_column :users, :role

    add_column :users, :isAdmin, :boolean
  end
end
