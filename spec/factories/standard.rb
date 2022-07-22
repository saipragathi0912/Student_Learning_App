FactoryBot.define do
    factory :standard do
      color {Faker::Color.color_name}
      classid {Faker::Number.between(from: 1, to: 4)}
    end
  end
  