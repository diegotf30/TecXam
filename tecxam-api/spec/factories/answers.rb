FactoryBot.define do
  factory :answer do
    question
    name  { Faker::Number.number(3) }
    parsed_name ""
    variables {{}}

    transient do
      number_of_variables 3
    end

    trait :with_variables do
      before(:create) do |answer, evaluator|
        vars = Faker::Lorem.words(evaluator.number_of_variables)

        vars.each do |var|
          answer.variables[var] = Array.new(3) { rand(1...9) }.to_s
          answer.name << " ^ #{var}"
        end
      end
    end
  end
end