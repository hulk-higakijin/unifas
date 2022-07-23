FactoryBot.define do
  factory :unidentified_account, class: Account do
    email { "unknown@example.com" }
    password { "myUnknownAccount" }
    password_confirmation { "myUnknownAccount" }
  end

  factory :professor_account, class: Account do
    email { "kanikani@example.com" }
    password { "kanikanizuwai" }
    password_confirmation { "kanikanizuwai" }
    status { "professor" }
  end

  factory :candidate_account, class: Account do
    email { "nipponiajapan@example.com" }
    password { "nipponiajapan" }
    password_confirmation { "nipponiajapan" }
    status { "candidate" }
  end

  factory :recruiter_account, class: Account do
    email { "recruiter@example.com" }
    password { "iamrecruiter" }
    password_confirmation { "iamrecruiter" }
    status { "professor" }
  end
end
