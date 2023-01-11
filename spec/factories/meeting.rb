FactoryBot.define do
    factory :meeting, class: 'Meeting' do
        association :organization
        title { Faker::Alphanumeric.alpha(number: 10) }
        body { Faker::Alphanumeric.alpha(number: 10) }
        scheduled_date { Date.today }
        zoom_link { Faker::Internet.url(host: 'us05web.zoom.us/') } #=> "http://example.com/clotilde.swift"
        zoom_id { Faker::Number.number(digits: 11) }
    end
end