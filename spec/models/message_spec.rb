require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(140) }

  describe '.by_users' do
    let(:message) { FactoryGirl.create(:message) }

    it 'includes messages by specified users' do
      expect(Message.by_users([message.user])).to include(message)
    end

    it 'excludes messages without specified users' do
      other_user = FactoryGirl.build_stubbed(:user)

      expect(Message.by_users([other_user])).to_not include(message)
    end
  end

  describe '#like!' do
    let(:message) { FactoryGirl.create(:message) }
    let(:user) { FactoryGirl.create(:user) }

    it 'adds like to a message' do
      expect { message.like!(user) }.to change { message.reload.likes_count }.from(0).to(1)
    end
  end
end
