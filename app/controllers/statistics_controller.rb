class StatisticsController < ApplicationController
  def show
    @time = params[:time] || :all
    @users_by_messages = User.by_messages_count(@time).limit(5)

    @users_by_likes = User.by_likes_count(@time).limit(5)
    @messages_by_likes = Message.where(user_id: @users_by_likes.map(&:id)).order(likes_count: :desc)
  end

  def update
    redirect_to statistics_url(time: params[:time])
  end
end
