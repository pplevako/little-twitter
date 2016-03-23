require 'rails_helper'

RSpec.describe StatisticsController, type: :controller do
  describe 'GET show' do
    it 'assigns @users_by_messages' do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:message, user: @user1)
      FactoryGirl.create(:message, user: @user2, created_at: 2.days.ago)

      get :show, by_messages_period: 'day'
      expect(assigns(:users_by_messages)).to eq([@user1])
    end
  end
end
