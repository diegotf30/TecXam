FactoryBot.define do
  factory :question do
    user
    name  { Faker::Lorem.question }
    tags []

    transient do
      number_of_tags 3
      number_of_answers 4
    end

    trait :with_tags do
      before(:create) do |question, evaluator|
        evaluator.number_of_tags.times do |n|
          question.tags << "tag#{n + 1}"
        end
      end
    end

    trait :with_answers do
      after(:create) do |question, evaluator|
        create_list :answer,
                    evaluator.number_of_answers,
                    question: question
      end
    end
  end
end