FactoryBot.define do
  factory :research do
    association :professor, factory: :recruiter
    association :faculty
    title { "we did found truth world" }
    body { "recreate the world..." }
  end
end