FactoryBot.define do
    factory :meeting, class: 'Meeting' do
        association :organization
        title { Faker::Alphanumeric.alpha(number: 10) }
        body { Faker::Alphanumeric.alpha(number: 10) }
        scheduled_date { Date.today }

        after(:build) do |user|
            user.class.skip_callback(:create)
        end

        trait :skip_validations do
            to_create { |instance| instance.save(validate: false) }
        end

    end
end