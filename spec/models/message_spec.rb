require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#like!' do
    let(:message) { FactoryGirl.create(:message) }
    let(:user) { FactoryGirl.create(:user) }

    it 'adds like to a message' do
      expect { message.like!(user) }.to change { message.reload.likes_count }.from(0).to(1)
    end
  end

  it { is_expected.to validate_presence_of(:content) }

  it { is_expected.to validate_presence_of(:user) }
end
