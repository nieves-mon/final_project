FactoryBot.define do
    factory :meeting, class: 'User_meeting' do
        association :organization
        association :meeting
        association :user

    end
end