FactoryBot.define do
  factory :university do
    association :prefecture
    name { "高崎未来総合大学" }
    url { "https://takasakimirai.themedia.jp/" }
    active { true }
    introduction { "未来より、今が大切。" }
  end
end
