class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.string :status
      t.references :friend_request_from, null: false, foreign_key: {to_table: :users}
      t.references :friend_request_to, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
