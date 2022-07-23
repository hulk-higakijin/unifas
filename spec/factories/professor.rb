FactoryBot.define do
  factory :professor do
    association :account, factory: :professor_account
    name { "ズワイガニ教授" }
    introduction { "ミシシッピ川からやってきた。" }
  end

  factory :recruiter, class: Professor do
    association :account, factory: :recruiter_account
    name { "メンセツ・キョウジュ" }
    introduction { "見つけたい！受験生のいいところ見つけたい！！" }
  end
end
