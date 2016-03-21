class AddNullConstraintToLikesUserId < ActiveRecord::Migration
  def change
    change_column_null :likes, :user_id, false
  end
end
