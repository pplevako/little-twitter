class Message < ActiveRecord::Base
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, length: {maximum: 140}

  def like!(user)
    self.likes.create(user: user)
  end
end
