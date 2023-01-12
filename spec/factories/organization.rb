FactoryBot.define do
    factory :organization, class: 'Organization' do
        name { Faker::Alphanumeric.alpha(number: 10) }
    end
  
  end