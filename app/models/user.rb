class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.top_by_messages_count(time_interval='all', limit=5)
    users = User.select('users.*, COUNT(messages.id) AS messages_count')
                .joins(:messages)
                .group('users.id')
                .order('messages_count DESC')
                .limit(limit)

    users = users.where('messages.created_at > ?', 1.day.ago) if time_interval == 'day'
    users = users.where('messages.created_at > ?', 1.week.ago) if time_interval == 'week'
    return users
  end
end
