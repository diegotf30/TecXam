class Answer < ApplicationRecord
  belongs_to :question
  before_save :parse

  alias_attribute :vars, :variables

  OPERATIONS = { 'sin' => 'Math.sin', 'cos' => 'Math.cos', 'tan' => 'Math.tan', 'mod' => '%' }

  def user
    question.user
  end

  def evaluate
    begin
      replace_variables(parsed_name)
      return eval(parsed_name).round(3)
    rescue Exception
      replace_variables(name)
      return name
    end
  end

  private

  def parse
    self.parsed_name = name

    self.parsed_name.gsub!(/(\^)/, '**') # Need special regex, because it's not a word
    OPERATIONS.each do |op, ruby_op|
      self.parsed_name.gsub!(/\b(#{op}|#{op.upcase})\b/, ruby_op)
    end
  end

  def replace_variables(str)
    vars.each do |var, values|
      str.gsub!(/\b(#{var})\b/, eval(values).sample.to_s)
    end
  end
end
