class Answer < ApplicationRecord
  belongs_to :question
  before_save :assure_whitespace, :define_variables

  def user
    question.user
  end

  private

  def assure_whitespace
    self.name = name.split.join(' ')
  end

  # Gets words starting with '#' and ignores real hashtags (starting with '\#')
  def define_variables
    self.variables = name.scan(/[^\\#]#([\w]*)/).flatten
  end
end
