FactoryBot.define do
    factory :question do
      question {Faker::Lorem.words(3)}
      solution {Faker::Lorem.words(3)}
      option_1 {Faker::Lorem.words(3)}
      option_2 {Faker::Lorem.words(3)}
      option_3 {Faker::Lorem.words(3)}
      option_4 {Faker::Lorem.words(3)}
    end
  end