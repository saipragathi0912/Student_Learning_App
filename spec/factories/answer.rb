FactoryBot.define do
    factory :answer do
      chosen_option {Faker::Lorem.words(3)}
      review false 
    end
  end
  