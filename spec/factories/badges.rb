FactoryBot.define do
  factory :badge do
    name { Faker::Lorem.unique.word + " Badge" }
    description { Faker::Lorem.sentence }
    image_url { "http://example.com/badge.png" }
    criteria { "Complete 5 trainings" }
    level { :silver }
  end
end
