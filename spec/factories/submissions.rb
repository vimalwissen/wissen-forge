FactoryBot.define do
  factory :submission do
    user
    assignment
    file_url { "http://example.com/submission.pdf" }
    grade { nil }

    trait :graded do
      grade { rand(60..100) }
    end
  end
end
