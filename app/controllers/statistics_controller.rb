class StatisticsController < ApplicationController
  def show
    @time_intervals = [[t('.all_time'), :all], [t('.day'), :day], [t('.week'), :week]]

    @selected_interval = params[:time_interval] || :all
    @users = User.top_by_messages_count(@selected_interval)
  end

  def update
    redirect_to statistics_url(time_interval: params[:time_interval])
  end
end
