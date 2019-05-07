class Question < ApplicationRecord
  has_and_belongs_to_many :exams
  has_many :answers
  belongs_to :user

  alias_attribute :vars, :variables

  def self.where_tag(tag)
    Question.where('tags @> ?', "{#{tag}}")
  end

  def add_tag(t)
    tags_will_change!
    tags << t
    save
  end

  def evaluate
    return replace_variables(name)
  end

  def solution
    return replace_last_chosen(name)
  end

  def correct_answers
    answers.where(correct: true)
  end

  private

  def replace_variables(str)
    vars.each do |var, possible_values|
      random_choice = choose_and_save_variable(var, possible_values)
      str = str.gsub(/\b(#{var}|#{var.upcase}|#{var.downcase})\b/, random_choice.to_s)
    end
    save

    return str
  end

  def replace_last_chosen(str)
    last_chosen_variables.each do |var, val|
      str = str.gsub(/\b(#{var}|#{var.upcase}|#{var.downcase})\b/, val.to_s)
    end

    return str
  end

  def choose_and_save_variable(var, values)
    self.last_chosen_variables[var] = eval(values).sample
  end
end
