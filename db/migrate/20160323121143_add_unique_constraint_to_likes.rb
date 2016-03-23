class AddUniqueConstraintToLikes < ActiveRecord::Migration
  def change
    add_index :likes, [:user_id, :likeable_type, :likeable_id], unique: true
  end
end
