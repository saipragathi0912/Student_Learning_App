FactoryBot.define do
    factory :exercise do
      total_duration {Faker::Number.number(digits: 2)}
      questions {Faker::Number.number(digits: 2)}
      name {Faker::Lorem.words(3)}
    end
  end