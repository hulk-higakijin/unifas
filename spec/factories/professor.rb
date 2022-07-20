FactoryBot.define do
  factory :professor do
    association :account
    
    name { "ズワイガニ教授" }
    introduction { "ミシシッピ川からやってきた。" }
  end
end
