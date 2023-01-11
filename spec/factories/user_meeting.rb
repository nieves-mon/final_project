FactoryBot.define do
    factory :participant, class: 'User_meeting' do
        association :organization
        association :meeting
        association :user

    end
end