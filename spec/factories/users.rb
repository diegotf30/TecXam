FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    transient do
      number_of_courses 3
      number_of_questions 3
    end

    trait :with_courses do
      after(:create) do |user, evaluator|
        create_list :course,
                    evaluator.number_of_courses,
                    user: user
      end
    end

    trait :with_questions do
      after(:create) do |user, evaluator|
        create_list :question,
                    evaluator.number_of_questions,
                    user: user
      end
    end
  end
end