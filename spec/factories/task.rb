FactoryBot.define do
    factory :task, class: 'Task' do
        association :project
        title { Faker::Alphanumeric.alpha(number: 10) }
        notes { Faker::Alphanumeric.alpha(number: 10) }
        duedate { Date.today }
        completed { true }
    end
end