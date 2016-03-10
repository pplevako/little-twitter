FactoryGirl.define do
  factory :user do
    email { Forgery(:internet).email_address }
    password { 'keyboardcat' }
  end
end
