class AddConstraintsToMessagesContent < ActiveRecord::Migration
  def change
    change_column :messages, :content, :string, :null => false, :limit => 140
  end
end
