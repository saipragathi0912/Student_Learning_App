FactoryBot.define do
    factory :board do
      name "CBSE"
      logo {Faker::Company.logo}
      color {Faker::Color.color_name}
      boardid {Faker::Number.between(from: 1, to: 4)}
    end
  end
  