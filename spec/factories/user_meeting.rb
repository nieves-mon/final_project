FactoryBot.define do
    factory :user_meeting, class: 'User_meeting' do
        association :meeting
        association :user
    end
end