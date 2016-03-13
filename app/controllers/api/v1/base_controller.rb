class Api::V1::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(error)
    render json: {errors: [error.message]}, status: :not_found
  end
end
