require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.by_messages_count' do
    let(:users) { User.by_messages_count }

    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:user)
      FactoryGirl.create(:message, user: @user1)
      FactoryGirl.create(:message, user: @user2)
      FactoryGirl.create(:message, user: @user2)
      @users = User.by_messages_count
    end

    it 'sorts users by messages count' do
      expect(users).to eq([@user2, @user1])
    end

    it 'adds messages_count to users' do
      expect(users.first.messages_count).to eq(2)
      expect(users.second.messages_count).to eq(1)
    end
    # TODO: add time parameter specs
  end

  describe '.by_likes_count' do
    let(:users) { User.by_likes_count }

    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:user)
      message1 = FactoryGirl.create(:message, user: @user1)
      message2 = FactoryGirl.create(:message, user: @user2)
      FactoryGirl.create(:like, likeable: message1)
      FactoryGirl.create(:like, likeable: message1)
      FactoryGirl.create(:like, likeable: message2)
    end

    it 'sorts users by likes count' do
      expect(users).to eq([@user1, @user2])
    end

    it 'adds max_likes_count to users' do
      expect(users.first.max_likes_count).to eq(2)
      expect(users.second.max_likes_count).to eq(1)
    end
  end

  describe '.by_likes_rating' do
    let(:users) { User.by_likes_rating }

    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:user)
      message1 = FactoryGirl.create(:message, user: @user1)
      message2 = FactoryGirl.create(:message, user: @user2)
      FactoryGirl.create(:message, user: @user2)
      FactoryGirl.create(:like, likeable: message1)
      FactoryGirl.create(:like, likeable: message2)
    end

    it 'sorts users by likes count' do
      expect(users).to eq([@user1, @user2])
    end

    it 'adds max_likes_count to users' do
      expect(users.first.likes_rating).to eq(1.0)
      expect(users.second.likes_rating).to eq(0.5)
    end
  end
end
