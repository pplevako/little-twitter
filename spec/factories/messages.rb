FactoryGirl.define do
  factory :message do
    content { Forgery::LoremIpsum.characters(100) }
    user
  end
end
