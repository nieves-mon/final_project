FactoryBot.define do
    factory :user, class: 'User' do
        association :organization
        email { Faker::Internet.email }
        password { '123456'}
        confirmation_sent_at { Date.today }
        confirmed_at { Date.today }
        invitation_accepted_at { Date.today }
        roles { {"employee": true } }
  
        after(:build) do |user|
            user.class.skip_callback(:create)
        end

        trait :skip_validations do
            to_create { |instance| instance.save(validate: false) }
        end
       
        trait :admin do
             roles { {"admin": true } }
        end
    end
  
  end
  