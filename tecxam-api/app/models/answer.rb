class Answer < ApplicationRecord
  belongs_to :question
  before_save :parse
  after_save :update_question_vars

  alias_attribute :vars, :variables

  OPERATIONS = { 'sin' => 'Math.sin', 'cos' => 'Math.cos', 'tan' => 'Math.tan', 'mod' => '%', 'sqrt' => 'Math.sqrt' }

  def user
    question.user
  end

  def evaluate(answer_key: false)
    begin
      return eval(replace_variables(answer_key, parsed_name)).round(3).to_s
    rescue Exception  # Answer contains text, so we only replace vars
      return replace_variables(answer_key, name)
    end
  end

  def last_chosen
    question.last_chosen_variables
  end

  def question_vars
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
    last_chosen.each do |var, val|
      str = str.gsub(/\b(#{var}|#{var.upcase}|#{var.downcase})\b/, val)
    end
    
    return str
  end

  def update_question_vars
    question_vars.merge!(vars).save
  end
end
