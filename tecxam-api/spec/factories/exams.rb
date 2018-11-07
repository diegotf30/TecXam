FactoryBot.define do
  factory :exam do
    course
    name  { Faker::Name.name }
    random_questions {}

    transient do
      number_of_questions 3
    end

    trait :with_questions do
      after(:create) do |exam, evaluator|
        questions = create_list :question, evaluator.number_of_questions, user: exam.user

        exam.add_question(questions)
      end
    end
  end
end