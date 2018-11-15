class Answer < ApplicationRecord
  belongs_to :question
  before_save :parse

  alias_attribute :vars, :variables

  OPERATIONS = { 'sin' => 'Math.sin', 'cos' => 'Math.cos', 'tan' => 'Math.tan', 'mod' => '%' }

  def user
    question.user
  end

  def evaluate(answer_key)
    begin
      str = parsed_name
      replace_variables(answer_key, str)
      return eval(str).round(3).to_s
    rescue Exception
      str = name
      replace_variables(answer_key, str)
      return str
    end
  end

  private

  def parse
    self.parsed_name = name

    self.parsed_name.gsub!(/(\^)/, '**') # Need special regex, because it's not a word
    OPERATIONS.each do |op, ruby_op|
      self.parsed_name.gsub!(/\b(#{op}|#{op.upcase}|#{op.downcase})\b/, ruby_op)
    end
  end

  def replace_variables(answer_key, str)
    (answer_key ? last_chosen_variables : vars).each do |var, values|
      random_choice = answer_key ? values : choose_and_save_var(var, values)
      str.gsub!(/\b(#{var}|#{var.upcase}|#{var.downcase})\b/, random_choice.to_s)
    end
    save
  end

  def choose_and_save_var(var, values)
    random_value = eval(values).sample
    self.last_chosen_variables[var] = random_value
    return random_value
  end
end
