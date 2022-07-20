FactoryBot.define do
  factory :account do
    email { "myAccout@example.com" }
    password { "myFirstAccount" }
    password_confirmation { "myFirstAccount" }
  end
end
