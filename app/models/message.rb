class Message < ActiveRecord::Base
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, length: { maximum: 140 }, presence: true
  validates_presence_of :user

  def like!(user)
    likes.create(user: user)
  end
end
