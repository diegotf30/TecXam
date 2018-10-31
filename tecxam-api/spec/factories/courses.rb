FactoryBot.define do
  factory :course do
    user
    name  { Faker::Name.name }
    acronym  { Faker::String.random(6) }
    description { Faker::Lorem.paragraph }

    transient do
      number_of_exams 3
    end

    trait :with_exams do
      after(:create) do |course, evaluator|
        create_list :exam,
                    evaluator.number_of_exams,
                    course: course
      end
    end
  end
end