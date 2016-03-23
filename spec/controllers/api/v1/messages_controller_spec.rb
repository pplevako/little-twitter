require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do
  include_context 'request json'
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET index' do
    before do
      get :index
    end

    it { is_expected.to respond_with(:ok) }
  end

  describe 'POST create' do
    before do
      login_with_token(user)
    end

    context 'invalid attributes' do
      before do
        post :create, message: { content: Forgery::LoremIpsum.characters(150) }
      end
      it { is_expected.to respond_with(:unprocessable_entity) }
    end

    context 'valid attributes' do
      let(:message_attributes) { FactoryGirl.attributes_for(:message) }
      let(:post_request) { post :create, message: message_attributes }

      it 'creates message' do
        expect { post_request }.to change(Message, :count).by(1)
      end

      it 'assigns attributes to a message' do
        post_request

        created_message = Message.last
        expect(created_message.content).to eql(message_attributes[:content])
      end

      it 'assigns user to a message' do
        post_request

        created_message = Message.last
        expect(created_message.user).to eql(user)
      end

      it 'responds with 201 status' do
        post_request
        is_expected.to respond_with(201)
      end
    end
  end

  describe 'PATCH like' do
    let(:message) { FactoryGirl.create(:message) }

    before do
      login_with_token(user)
    end

    it 'adds like to a message' do
      expect { patch :like, id: message.id }.to change { message.reload.likes_count }.from(0).to(1)
    end
    # TODO: test json contents
  end
end
