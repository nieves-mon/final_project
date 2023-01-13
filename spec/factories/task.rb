FactoryBot.define do
    factory :task, class: 'Task' do
        association :project
        title { Faker::Alphanumeric.alpha(number: 10) }
        notes { Faker::Alphanumeric.alpha(number: 10) }
        completed { true }
        duedate { Date.current }
    end
end
