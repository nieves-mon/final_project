FactoryBot.define do
    factory :project, class: 'Project' do
        association :organization
        title { Faker::Alphanumeric.alpha(number: 10) }
        body { Faker::Alphanumeric.alpha(number: 10) }
        start_date { Date.current }
        end_date { Date.tomorrow }
    end
end
