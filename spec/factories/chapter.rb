FactoryBot.define do
    factory :chapter do
      name {Faker::Lorem.words(3)}
    end
  end
  