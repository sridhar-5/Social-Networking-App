class RenameLikeToReaction < ActiveRecord::Migration[7.0]
  def change
    rename_table :likes, :reactions
  end
end
