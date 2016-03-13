class Api::V1::MessagesController < Api::V1::BaseController
  before_action :authenticate_user!, only: [:create, :like]

  def index
    @messages = Message.all
    respond_with @messages
  end

  def create
    @message = current_user.messages.create(message_params)
    respond_with :api, :v1, @message
  end

  def like
    @message.like!(current_user)
    render json: @message
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
