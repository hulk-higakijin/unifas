FactoryBot.define do
  factory :candidate do
    association :account, factory: :candidate_account
    name { "ニッポニア・ニッポン太郎" }
    introduction { "極めよ、愛国精神。" }
  end
end
