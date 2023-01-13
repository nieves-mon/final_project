FactoryBot.define do
    factory :project_participant, class: 'Project_participant' do
        association :project
        association :user
    end
end