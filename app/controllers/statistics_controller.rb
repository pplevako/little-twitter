class StatisticsController < ApplicationController
  def show
    @users_by_messages = User.by_messages_count(params[:time]).limit(5)

    @users_by_likes = User.by_likes_count(params[:time]).limit(5)
    @messages_by_likes = Message.where(user_id: @users_by_likes.map(&:id)).order(likes_count: :desc)

    @users_by_likes_rating = User.by_likes_rating(params[:time]).limit(5)
  end
end
