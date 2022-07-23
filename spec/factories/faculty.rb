FactoryBot.define do
  factory :faculty do
    association :university
    name { "タイ国際学部" }
  end
end
