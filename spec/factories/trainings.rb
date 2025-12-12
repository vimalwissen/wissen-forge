FactoryBot.define do
  factory :training do
    title { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }
    training_type { :online }
    mode { :optional }
    start_time { 1.day.from_now }
    end_time { 2.days.from_now }
    capacity { 20 }
    instructor { Faker::Name.name }
    status { :published }
    assignment_scope { :assign_all }

    trait :classroom do
      training_type { :classroom }
    end

    trait :mandatory do
      mode { :mandatory }
    end

    trait :pending do
      status { :pending_approval }
    end

    trait :past do
      start_time { 1.month.ago }
      end_time { 1.month.ago + 1.day }
    end
  end
end
