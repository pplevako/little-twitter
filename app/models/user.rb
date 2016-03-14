class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :messages, dependent: :destroy

  def self.by_messages_count(time='all')
    users = User.select('users.*, COUNT(messages.id) AS messages_count')
                .joins(:messages)
                .group('users.id')
                .order('messages_count DESC')

    # TODO refactor this repeating code
    users = users.where('messages.created_at > ?', 1.day.ago) if time == 'day'
    users = users.where('messages.created_at > ?', 1.week.ago) if time == 'week'
    return users
  end

  def self.by_likes_count(time='all')
    users = User.select('users.*, MAX(messages.likes_count) AS max_likes_count')
                .joins(:messages)
                .group('users.id')
                .order('max_likes_count DESC')

    users = users.where('messages.created_at > ?', 1.day.ago) if time == 'day'
    users = users.where('messages.created_at > ?', 1.week.ago) if time == 'week'
    return users
  end

  def self.by_likes_rating(time='all')
    users = User.select('users.*, AVG(messages.likes_count) AS likes_rating')
                .joins(:messages)
                .group('users.id')
                .having('AVG(messages.likes_count) > 0')
                .order('likes_rating DESC')

    users = users.where('messages.created_at > ?', 1.day.ago) if time == 'day'
    users = users.where('messages.created_at > ?', 1.week.ago) if time == 'week'
    return users
  end
end
