class AddLikesCountToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :likes_count, :integer, default: 0
  end
end
