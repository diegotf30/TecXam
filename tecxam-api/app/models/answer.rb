class Answer < ApplicationRecord
  belongs_to :question
  before_save :parse
  before_save :add_vars_to_question

  OPERATIONS = { 'sin' => 'Math.sin', 'cos' => 'Math.cos', 'tan' => 'Math.tan', 'mod' => '%', 'sqrt' => 'Math.sqrt' }

  def user
    question.user
  end

  def evaluate(answer_key: false)
    begin
      return eval(replace_variables(answer_key, parsed_name)).round(3).to_s
    rescue Exception
      return replace_variables(answer_key, name)
    end
  end

  def last_chosen_variables
    question.last_chosen_variables
  end

  def variables
    question.variables
  end

  def vars
    question.vars
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
      random_choice = answer_key ? values : choose_and_save_variable(var, values)
      str = str.gsub(/\b(#{var}|#{var.upcase}|#{var.downcase})\b/, random_choice.to_s)
    end
    save

    return str
  end

  def choose_and_save_variable(var, values)
    self.last_chosen_variables[var] = eval(values).sample
  end
end
