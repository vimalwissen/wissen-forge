FactoryBot.define do
  factory :enrollment do
    user
    training
    status { :enrolled }
    completion_date { nil }
    score { nil }

    trait :completed do
      status { :completed }
      completion_date { Time.current }
      score { rand(80..100) }
    end
  end
end
