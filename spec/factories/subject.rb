FactoryBot.define do
    factory :subject do
      name {Faker::Lorem.words(3)}
      progress {Faker::Number.between(from: 0.0, to: 100.0).round(2)}
    end
  end