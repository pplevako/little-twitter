require 'rails_helper'

RSpec.describe Api::V1::BaseController, type: :controller do
  controller do
    def index
      raise ActiveRecord::RecordNotFound
    end
  end

  before do
    get :index
  end

  it { is_expected.to respond_with(:not_found) }
  # TODO: check json contents
end
