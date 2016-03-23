require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.by_messages_period' do
    before do
      Timecop.freeze(Time.current)
    end

    after do
      Timecop.return
    end

    context "when a period parameter equals 'week'" do
      it 'includes users with messages newer than week' do
        @message = FactoryGirl.create(:message, created_at: 7.days.ago + 10.minutes)

        expect(User.by_messages_period('week')).to include(@message.user)
      end

      it 'excludes users with messages created more than a week ago' do
        @message = FactoryGirl.create(:message, created_at: 7.days.ago - 10.minutes)

        expect(User.by_messages_period('week')).to_not include(@message.user)
      end
    end

    context "when a period parameter equals 'day'" do
      it 'includes users with messages newer than day' do
        @message = FactoryGirl.create(:message, created_at: 1.day.ago + 10.minutes)

        expect(User.by_messages_period('day')).to include(@message.user)
      end

      it 'excludes users with messages created more than a day ago' do
        @message = FactoryGirl.create(:message, created_at: 1.day.ago - 10.minutes)

        expect(User.by_messages_period('day')).to_not include(@message.user)
      end
    end

    context 'when a period not specified' do
      it 'includes all users' do
        @old_message = FactoryGirl.create(:message, created_at: 100.days.ago)
        @recent_message = FactoryGirl.create(:message)

        expect(User.by_messages_period(nil)).to include(@old_message.user, @recent_message.user)
      end
    end

    # etc.
  end

  describe '.by_messages_count' do
    let(:users) { User.by_messages_count }

    before do
      @top_user = FactoryGirl.create(:user)
      @second_user = FactoryGirl.create(:user)
      FactoryGirl.create(:user)
      FactoryGirl.create(:message, user: @top_user)
      FactoryGirl.create(:message, user: @top_user)
      FactoryGirl.create(:message, user: @second_user)
      @users = User.by_messages_count
    end

    it 'sorts users by messages count' do
      expect(users).to eq([@top_user, @second_user])
    end

    it 'adds messages_count to users' do
      expect(users.first.messages_count).to eq(2)
      expect(users.second.messages_count).to eq(1)
    end
  end

  describe '.by_likes_count' do
    let(:users) { User.by_likes_count }

    before do
      @top_user = FactoryGirl.create(:user)
      @second_user = FactoryGirl.create(:user)
      FactoryGirl.create(:user)
      top_message = FactoryGirl.create(:message, user: @top_user)
      second_message = FactoryGirl.create(:message, user: @second_user)
      FactoryGirl.create(:like, likeable: top_message)
      FactoryGirl.create(:like, likeable: top_message)
      FactoryGirl.create(:like, likeable: second_message)
    end

    it 'sorts users by likes count' do
      expect(users).to eq([@top_user, @second_user])
    end

    it 'adds max_likes_count to users' do
      expect(users.first.max_likes_count).to eq(2)
      expect(users.second.max_likes_count).to eq(1)
    end
  end

  describe '.by_likes_rating' do
    let(:users) { User.by_likes_rating }

    before do
      @top_user = FactoryGirl.create(:user)
      @second_user = FactoryGirl.create(:user)
      FactoryGirl.create(:user)
      top_message = FactoryGirl.create(:message, user: @top_user)
      second_message = FactoryGirl.create(:message, user: @second_user)
      FactoryGirl.create(:message, user: @second_user)
      FactoryGirl.create(:like, likeable: top_message)
      FactoryGirl.create(:like, likeable: second_message)
    end

    it 'sorts users by likes count' do
      expect(users).to eq([@top_user, @second_user])
    end

    it 'adds max_likes_count to users' do
      expect(users.first.likes_rating).to eq(1.0)
      expect(users.second.likes_rating).to eq(0.5)
    end
  end
end
