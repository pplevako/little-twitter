class StatisticsController < ApplicationController
  has_scope :by_messages_period

  def show
    @users_by_messages = apply_scopes(User.by_messages_count).limit(5)

    @users_by_likes = apply_scopes(User.by_likes_count).limit(5)
    @messages_by_likes = Message.by_users(@users_by_likes).order(likes_count: :desc)

    @users_by_likes_rating = apply_scopes(User.by_likes_rating).limit(5)
  end
end
