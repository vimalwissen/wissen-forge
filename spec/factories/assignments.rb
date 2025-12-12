FactoryBot.define do
  factory :assignment do
    training
    title { Faker::Educator.course_name + " Assignment" }
    description { Faker::Lorem.paragraph }
    due_date { 1.week.from_now }
  end
end
