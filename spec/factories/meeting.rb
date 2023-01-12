FactoryBot.define do
    factory :meeting, class: 'Meeting' do
        association :organization
        title { Faker::Alphanumeric.alpha(number: 10) }
        body { Faker::Alphanumeric.alpha(number: 10) }
        scheduled_date { Date.today }
    end
end