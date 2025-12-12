FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password" }
    designation { "Software Engineer" }
    department { "Engineering" }
    role { :employee }

    trait :admin do
      role { :admin }
    end

    trait :super_admin do
      role { :super_admin }
    end
    
    trait :manager do
      after(:create) do |user|
        create_list(:user, 3, manager_id: user.id)
      end
    end
  end
end
