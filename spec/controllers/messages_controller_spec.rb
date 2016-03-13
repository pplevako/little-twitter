require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do
  include_context 'request json'

  describe 'GET index' do
    before do
      get :index
    end

    it { is_expected.to respond_with(:ok) }
  end

  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      login_with_token(user)
    end

    context 'invalid attributes' do
      before do
        post :create, message: {content: Forgery::LoremIpsum.characters(150)}
      end
      it { is_expected.to respond_with(:unprocessable_entity) }
    end

    context 'valid attributes' do
      let(:message_attributes) { FactoryGirl.attributes_for(:message) }
      let(:post_request) { post :create, message: message_attributes }

      it 'creates message' do
        expect { post_request }.to change(Message, :count).by(1)
      end

      it {
        post_request
        is_expected.to respond_with(201)
      }
    end
  end
end
