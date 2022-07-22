FactoryBot.define do
    factory :token, class: "Doorkeeper::AccessToken" do
      scopes { "public" }
    end
  end