class Api::V1::MessagesController < Api::V1::BaseController
  before_action :authenticate_user!, only: [:create]

  def index
    @messages = Message.all
    render json: @messages
  end

  def create
    @message = current_user.messages.create(message_params)
    render json: @message
  end

  def like
    @message.like!
    render json: @message
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
