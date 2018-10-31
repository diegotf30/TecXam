FactoryBot.define do
  factory :answer do
    question
    name  { Faker::Name.name }
    variables []

    trait :with_variables do
      before(:create) do |answer, evaluator|
        variables = Faker::Lorem.characters(evaluator.number_of_questions)

        answer.variables |= variables
        variables.each do |var|
          answer.name << " \##{var}"
        end
      end
    end
  end
end