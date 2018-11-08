FactoryBot.define do
  factory :answer do
    question
    name  { Faker::Number.number(3) }
    variables {{}}

    transient do
      number_of_variables 3
    end

    trait :with_variables do
      after(:create) do |answer, evaluator|
        ops = ['+', '-', '*', '^', '/']

        vars = Faker::Lorem.characters(evaluator.number_of_variables).split('')

        vars.each do |var|
          answer.variables[var] = Array.new(4) { rand(1...9) }.to_s
          answer.name << " #{ops.sample} #{var}"
        end
      end
    end
  end
end