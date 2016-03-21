class AddNullConstraintToLikesLikeable < ActiveRecord::Migration
  def change
    change_column_null :likes, :likeable_id, false
    change_column_null :likes, :likeable_type, false
  end
end
