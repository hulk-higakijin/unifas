FactoryBot.define do
  factory :recruitment do
    association :professor, factory: :recruiter
    association :faculty
    title { "create superfuture!!!" }
    body { "know past, create future" }
  end
end
