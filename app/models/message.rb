class Message < ActiveRecord::Base
  belongs_to :user
  has_many :likes, as: :likeable

  validates :content, length: {maximum: 140}
end
