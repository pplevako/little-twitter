require 'rails_helper'

RSpec.describe Like, type: :model do
  it { is_expected.to validate_presence_of(:user) }
end
