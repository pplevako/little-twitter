user1 = FactoryGirl.create(:user)
user2 = FactoryGirl.create(:user)
user3 = FactoryGirl.create(:user)

message1 = FactoryGirl.create(:message, user: user1, created_at: 1.days.ago)
message2 = FactoryGirl.create(:message, user: user1, created_at: 1.days.ago)
message3 = FactoryGirl.create(:message, user: user1)

message4 = FactoryGirl.create(:message, user: user3)
message5 = FactoryGirl.create(:message, user: user3)

FactoryGirl.create(:like, likeable: message1)
FactoryGirl.create(:like, likeable: message2)

FactoryGirl.create(:like, likeable: message4)
FactoryGirl.create(:like, likeable: message5)
FactoryGirl.create(:like, likeable: message5)
