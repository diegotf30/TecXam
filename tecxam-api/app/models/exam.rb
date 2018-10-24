class Exam < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :questions

  def add_question(q)
    questions << q
  end
end
