class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :messages, dependent: :destroy

  scope :by_messages_created_after, -> (datetime) { joins(:messages).where('messages.created_at > ?', datetime) }

  def self.by_messages_period(period)
    case period
    when 'day'
      by_messages_created_after(1.day.ago)
    when 'week'
      by_messages_created_after(1.week.ago)
    else
      all
    end
  end

  def self.by_messages_count
    select('users.*, COUNT(messages.id) AS messages_count')
      .joins(:messages)
      .group('users.id')
      .order('messages_count DESC')
  end

  def self.by_likes_count
    select('users.*, MAX(messages.likes_count) AS max_likes_count')
      .joins(:messages)
      .group('users.id')
      .order('max_likes_count DESC')
  end

  def self.by_likes_rating
    select('users.*, AVG(messages.likes_count) AS likes_rating')
      .joins(:messages)
      .group('users.id')
      .having('AVG(messages.likes_count) > 0')
      .order('likes_rating DESC')
  end
end
