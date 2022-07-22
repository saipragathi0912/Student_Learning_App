FactoryBot.define do
    factory :user do
      email {Faker::Internet.email }
      mobilenumber {'+91'+Faker::Number.number(digits: 10).to_s}
      password {Faker::Internet.password(min_length: 8)}
      dob {Faker::Date.birthday(min_age: 12, max_age: 19).to_s}
      name {Faker::Movies::StarWars.character}
    end
  end
  