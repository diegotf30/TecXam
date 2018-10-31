FactoryBot.define do
  factory :exam do
    course
    is_random false
    name  { Faker::Name.name }

    transient do
      number_of_questions 3
    end

    trait :random do
      is_random true
    end

    trait :with_questions do
      after(:create) do |exam, evaluator|
        questions = create_list :question, evaluator.number_of_questions

        exam.add_question(questions)
      end
    end
  end
end